import 'package:dantex/providers/auth.dart';
import 'package:dantex/ui/add_book/add_custom_book_screen.dart';
import 'package:dantex/ui/backup/book_management_screen.dart';
import 'package:dantex/ui/book_detail/book_detail_screen.dart';
import 'package:dantex/ui/book_detail/notes_screen.dart';
import 'package:dantex/ui/book_list/wishlist_screen.dart';
import 'package:dantex/ui/edit_book/edit_book_screen.dart';
import 'package:dantex/ui/home/home_screen.dart';
import 'package:dantex/ui/profile/profile_screen.dart';
import 'package:dantex/ui/recommendations/recommendations_screen.dart';
import 'package:dantex/ui/settings/contributors_screen.dart';
import 'package:dantex/ui/settings/settings_screen.dart';
import 'package:dantex/ui/sign_in/forgot_password_screen.dart';
import 'package:dantex/ui/sign_in/sign_in_screen.dart';
import 'package:dantex/ui/sign_in/sign_up_screen.dart';
import 'package:dantex/ui/sign_in/splash_screen.dart';
import 'package:dantex/ui/statistics/statistics_screen.dart';
import 'package:dantex/ui/timeline/timeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final _key = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(Ref ref) {
  final authStateChanges = ref.watch(authStateChangesProvider);

  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: SplashScreen.routeLocation,
    routes: [
      GoRoute(
        path: SplashScreen.routeLocation,
        name: SplashScreen.routeName,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: HomeScreen.routeLocation,
        name: HomeScreen.routeName,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: SignInScreen.routeLocation,
        name: SignInScreen.routeName,
        builder: (context, state) {
          return const SignInScreen();
        },
        routes: [
          GoRoute(
            path: SignUpScreen.routeLocation,
            name: SignUpScreen.routeName,
            builder: (context, state) {
              return const SignUpScreen();
            },
          ),
          GoRoute(
            path: ForgotPasswordScreen.routeLocation,
            name: ForgotPasswordScreen.routeName,
            builder: (context, state) {
              return const ForgotPasswordScreen();
            },
          ),
        ],
      ),
      GoRoute(
        path: BookManagementScreen.routeLocation,
        name: BookManagementScreen.routeName,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const BookManagementScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const curve = Curves.easeInOut;
            final curvedAnimation =
                CurvedAnimation(parent: animation, curve: curve);

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: AddCustomBookScreen.routeLocation,
        name: AddCustomBookScreen.routeName,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AddCustomBookScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const curve = Curves.easeInOut;
            final curvedAnimation =
                CurvedAnimation(parent: animation, curve: curve);

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: EditBookScreen.routeLocation,
        name: EditBookScreen.routeName,
        pageBuilder: (context, state) {
          final bookId = state.pathParameters['bookId'] ?? '';

          return CustomTransitionPage(
            key: state.pageKey,
            child: EditBookScreen(bookId: bookId),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const curve = Curves.easeInOut;
              final curvedAnimation =
                  CurvedAnimation(parent: animation, curve: curve);

              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: ProfileScreen.routeLocation,
        name: ProfileScreen.routeName,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const ProfileScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const curve = Curves.easeInOut;
              final curvedAnimation =
                  CurvedAnimation(parent: animation, curve: curve);

              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: WishlistScreen.routeLocation,
        name: WishlistScreen.routeName,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const WishlistScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const curve = Curves.easeInOut;
              final curvedAnimation =
                  CurvedAnimation(parent: animation, curve: curve);

              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: SettingsScreen.routeLocation,
        name: SettingsScreen.routeName,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const SettingsScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const curve = Curves.easeInOut;
              final curvedAnimation =
                  CurvedAnimation(parent: animation, curve: curve);

              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              );
            },
          );
        },
        routes: [
          GoRoute(
            path: ContributorsScreen.routeLocation,
            name: ContributorsScreen.routeName,
            builder: (context, state) => const ContributorsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: TimelineScreen.routeLocation,
        name: TimelineScreen.routeName,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const TimelineScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const curve = Curves.easeInOut;
              final curvedAnimation =
                  CurvedAnimation(parent: animation, curve: curve);

              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: StatisticsScreen.routeLocation,
        name: StatisticsScreen.routeName,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const StatisticsScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const curve = Curves.easeInOut;
              final curvedAnimation =
                  CurvedAnimation(parent: animation, curve: curve);

              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: RecommendationsScreen.routeLocation,
        name: RecommendationsScreen.routeName,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const RecommendationsScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const curve = Curves.easeInOut;
              final curvedAnimation =
                  CurvedAnimation(parent: animation, curve: curve);

              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: BookDetailScreen.routeLocation,
        name: BookDetailScreen.routeName,
        pageBuilder: (context, state) {
          final bookId = state.pathParameters['bookId'] ?? '';

          return CustomTransitionPage(
            key: state.pageKey,
            child: BookDetailScreen(bookId: bookId),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const curve = Curves.easeInOut;
              final curvedAnimation =
                  CurvedAnimation(parent: animation, curve: curve);

              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              );
            },
          );
        },
        routes: [
          GoRoute(
            path: NotesScreen.routeLocation,
            name: NotesScreen.routeName,
            builder: (context, state) {
              final bookId = state.pathParameters['bookId'] ?? '';
              return NotesScreen(bookId: bookId);
            },
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      // If our async state is loading, don't perform redirects, yet
      if (authStateChanges.isLoading || authStateChanges.hasError) {
        return null;
      }

      // Here we guarantee that hasData == true, i.e. we have a readable value
      // This has to do with how the FirebaseAuth SDK handles the "log-in" state
      // Returning `null` means "we are not authorized"
      final isAuth = authStateChanges.valueOrNull != null;

      final isSplash = state.matchedLocation == SplashScreen.routeLocation;
      if (isSplash) {
        return isAuth ? HomeScreen.routeLocation : SignInScreen.routeLocation;
      }

      final isLoggingIn = state.matchedLocation == SignInScreen.routeLocation ||
          state.matchedLocation == SignUpScreen.routeLocation;
      if (isLoggingIn) {
        return isAuth ? HomeScreen.routeLocation : null;
      }

      return null;
    },
  );
}
