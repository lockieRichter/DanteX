import 'package:dantex/providers/auth.dart';
import 'package:dantex/ui/backup/book_management_screen.dart';
import 'package:dantex/ui/book_list/wishlist_screen.dart';
import 'package:dantex/ui/profile/profile_screen.dart';
import 'package:dantex/ui/recommendations/recommendations_screen.dart';
import 'package:dantex/ui/settings/settings_screen.dart';
import 'package:dantex/ui/shared/sign_out_button.dart';
import 'package:dantex/ui/shared/user_avatar.dart';
import 'package:dantex/ui/statistics/statistics_screen.dart';
import 'package:dantex/ui/timeline/timeline_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DanteBottomSheet extends ConsumerWidget {
  const DanteBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(32),
              onTap: () async => context.push(ProfileScreen.routeLocation),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    UserAvatar(),
                    SizedBox(width: 8),
                    Expanded(child: _UserTag(key: ValueKey('user_tag'))),
                    SignOutButton(key: ValueKey('sign_out_button')),
                  ],
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 32,
                childAspectRatio: 2,
              ),
              children: [
                _MenuItem(
                  text: 'navigation.stats',
                  icon: Icons.pie_chart_outline_outlined,
                  onItemClicked: () async => context.push(
                    StatisticsScreen.routeLocation,
                  ),
                ),
                _MenuItem(
                  text: 'navigation.timeline',
                  icon: Icons.linear_scale_outlined,
                  onItemClicked: () async => context.push(
                    TimelineScreen.routeLocation,
                  ),
                ),
                _MenuItem(
                  text: 'navigation.wishlist',
                  icon: Icons.article_outlined,
                  onItemClicked: () async => context.push(
                    WishlistScreen.routeLocation,
                  ),
                ),
                _MenuItem(
                  text: 'navigation.recommendations',
                  icon: Icons.whatshot_outlined,
                  onItemClicked: () async => context.push(
                    RecommendationsScreen.routeLocation,
                  ),
                ),
                _MenuItem(
                  text: 'navigation.book_keeping',
                  icon: Icons.all_inbox_outlined,
                  onItemClicked: () async => context.push(
                    BookManagementScreen.routeLocation,
                  ),
                ),
                _MenuItem(
                  text: 'navigation.settings',
                  icon: Icons.settings_outlined,
                  onItemClicked: () async => context.push(
                    SettingsScreen.routeLocation,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UserTag extends ConsumerWidget {
  const _UserTag({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return user.maybeWhen(
      data: (user) {
        if (user == null) {
          return const SizedBox.shrink();
        }

        if (user.isAnonymous) {
          return Text(
            'authentication.anonymous_user',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
          ).tr();
        }

        final name = user.displayName;
        final email = user.email;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (name != null)
              Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (email != null)
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.text,
    required this.icon,
    required this.onItemClicked,
  });
  final String text;
  final IconData icon;
  final VoidCallback onItemClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onItemClicked,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
          const SizedBox(height: 4),
          Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          ).tr(),
        ],
      ),
    );
  }
}
