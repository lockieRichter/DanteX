import 'package:dantex/logger/event.dart';
import 'package:dantex/providers/book.dart';
import 'package:dantex/providers/google.dart';
import 'package:dantex/providers/logger.dart';
import 'package:dantex/ui/core/pulsing_grid.dart';
import 'package:dantex/ui/core/subtitle_icon.dart';
import 'package:dantex/ui/home/home_page.dart';
import 'package:dantex/ui/management/backup_list_card.dart';
import 'package:dantex/ui/management/book_restore_strategy.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookManagementPage extends ConsumerWidget {
  const BookManagementPage({super.key});

  static String get routeName => 'management';
  static String get routeLocation => '/management';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleDriveBackups = ref.watch(googleDriveBackupsProvider);
    final backupInProgress = ref.watch(backupInProgressNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        title: Text('book_management.title'.tr()),
        leading: BackButton(
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: backupInProgress
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PulsingGrid(),
                    SizedBox(height: 16),
                    Text('Restoring from backup...'),
                  ],
                ),
              )
            : googleDriveBackups.when(
                data: (backups) {
                  if (backups.isEmpty) {
                    return const Center(child: Text('No backups found'));
                  }

                  return ListView.separated(
                    itemCount: backups.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // Put an empty SizedBox at the top of the list to add a
                        // separator between the app bar and the list.
                        return const SizedBox.shrink();
                      }
                      final backup = backups[index - 1];
                      return BackupListCard(
                        backup: backup,
                        onTap: () async =>
                            _onTapBackup(context, ref, backup.id),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                  );
                },
                error: (e, s) =>
                    Center(child: Text('Error $e, stacktrace: $s')),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }

  Future<void> _onTapBackup(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final restoreStrategy = await showDialog<RestoreStrategy>(
      context: context,
      builder: (context) => const _RestoreBackupDialog(
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
      final backupBooks = await backupRepository.fetchBackup(id);
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

    if (context.mounted) {
      context.go(HomePage.routeLocation);
    }
  }
}

class _RestoreBackupDialog extends StatelessWidget {
  const _RestoreBackupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.devices_other_outlined),
          const SizedBox(width: 8),
          Text('book_management.restore_strategy'.tr()),
        ],
      ),
      content: Text('book_management.restore_detail'.tr()),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
                onPressed: () =>
                    Navigator.of(context).pop(RestoreStrategy.merge),
                child: SizedBox(
                  child: SubtitleIcon(
                    size: 24,
                    icon: Icons.merge,
                    subtitle: 'book_management.merge'.tr(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
                onPressed: () =>
                    Navigator.of(context).pop(RestoreStrategy.overwrite),
                child: SubtitleIcon(
                  size: 24,
                  icon: Icons.content_copy_outlined,
                  subtitle: 'book_management.overwrite'.tr(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
