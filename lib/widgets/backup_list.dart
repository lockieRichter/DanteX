import 'package:dantex/logger/event.dart';
import 'package:dantex/models/backup_data.dart';
import 'package:dantex/models/book_restore_strategy.dart';
import 'package:dantex/providers/book.dart';
import 'package:dantex/providers/google.dart';
import 'package:dantex/providers/logger.dart';
import 'package:dantex/screens/home_screen.dart';
import 'package:dantex/widgets/backup_list_card.dart';
import 'package:dantex/widgets/pulsing_grid.dart';
import 'package:dantex/widgets/restore_backup_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BackupList extends ConsumerStatefulWidget {
  const BackupList({super.key});

  @override
  ConsumerState<BackupList> createState() => _BackupListState();
}

class _BackupListState extends ConsumerState<BackupList>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // This mixin is used to keep the state of the widget when switching tabs so
  // that the list doesn't get rebuilt every time the tab is switched.
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final googleDriveBackups = ref.watch(googleDriveBackupsProvider);
    final backupInProgress = ref.watch(backupInProgressNotifierProvider);

    if (backupInProgress) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PulsingGrid(),
            SizedBox(height: 16),
            Text('Restoring from backup...'),
          ],
        ),
      );
    }

    return googleDriveBackups.when(
      data: (backups) {
        if (backups.isEmpty) {
          return const Center(child: Text('No backups found'));
        }

        return RefreshIndicator(
          onRefresh: () async => ref.refresh(googleDriveBackupsProvider),
          child: AnimatedList.separated(
            key: _listKey,
            initialItemCount: backups.length + 1,
            itemBuilder: (context, index, animation) {
              if (index == 0) {
                // Put an empty SizedBox at the top of the list to add a
                // separator between the app bar and the list.
                return const SizedBox.shrink();
              }
              final backup = backups[index - 1];
              return SizeTransition(
                sizeFactor: animation,
                child: BackupListCard(
                  backup: backup,
                  onTap: () async => _onTapBackup(backup),
                  onRemove: () async {
                    _listKey.currentState?.removeItem(
                      index,
                      (context, animation) => SizeTransition(
                        sizeFactor: animation,
                        child: const Card.outlined(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(height: 116),
                            ],
                          ),
                        ),
                      ),
                      duration: const Duration(milliseconds: 200),
                    );
                  },
                ),
              );
            },
            separatorBuilder: (context, index, animation) =>
                const SizedBox(height: 16),
            removedSeparatorBuilder: (context, index, animation) =>
                const SizedBox(height: 16),
          ),
        );
      },
      error: (e, s) => Center(child: Text('Error $e, stacktrace: $s')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _onTapBackup(BackupData backup) async {
    final restoreStrategy = await showDialog<RestoreStrategy>(
      context: context,
      builder: (context) => const RestoreBackupDialog(
        key: ValueKey('restore_backup_dialog'),
      ),
    );
    if (restoreStrategy == null) {
      return;
    }

    final logger = ref.read(loggerProvider);
    final bookRepository = ref.read(bookRepositoryProvider);
    final progressNotifier = ref.read(backupInProgressNotifierProvider.notifier)
      ..start();

    try {
      final backupRepository = await ref.read(backupRepositoryProvider.future);
      final backupBooks = await backupRepository.fetchBackup(
        backup.id,
        isLegacyBackup: backup.isLegacyBackup,
      );
      if (restoreStrategy == RestoreStrategy.merge) {
        await bookRepository.mergeBooks(backupBooks);
      } else {
        await bookRepository.overwriteBooks(backupBooks);
      }
      logger.trackEvent(
        DanteEvent.restoreBackupFromGoogleDrive,
        data: {
          'strategy': restoreStrategy.name,
        },
      );
    } finally {
      progressNotifier.done();
    }

    if (mounted) {
      context.go(HomeScreen.routeLocation);
    }
  }
}
