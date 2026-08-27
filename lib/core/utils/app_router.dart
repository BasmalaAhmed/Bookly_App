import 'package:bookly_app/core/utils/service_locator.dart';
import 'package:bookly_app/features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/features/notifications/data/repos/notification_repo.dart';
import 'package:bookly_app/features/notifications/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:bookly_app/features/notifications/presentation/manager/notification_settings_cubit/notification_settings_cubit.dart';
import 'package:bookly_app/features/notifications/presentation/views/notifications_view.dart';
import 'package:bookly_app/features/settings/presentation/manager/change_email_cubit/change_email_cubit.dart';
import 'package:bookly_app/features/auth/presentation/views/forgot_password_view.dart';
import 'package:bookly_app/features/auth/presentation/views/login_view.dart';
import 'package:bookly_app/features/auth/presentation/views/register_view.dart';
import 'package:bookly_app/features/favorites/presentation/views/favorite_view.dart';
import 'package:bookly_app/features/home/data/models/book_model.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:bookly_app/features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/manager/similar_books_cubit/similar_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/views/book_details_view.dart';
import 'package:bookly_app/features/home/presentation/views/home_view.dart';
import 'package:bookly_app/features/main/presentation/views/main_view.dart';
import 'package:bookly_app/features/profile/data/repos/profile_repo.dart';
import 'package:bookly_app/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/features/profile/presentation/views/profile_view.dart';
import 'package:bookly_app/features/search/data/repos/search_repo.dart';
import 'package:bookly_app/features/search/presentation/manager/cubit/search_cubit.dart';
import 'package:bookly_app/features/search/presentation/views/search_view.dart';
import 'package:bookly_app/features/settings/presentation/manager/change_password_cubit/change_password_cubit.dart';
import 'package:bookly_app/features/settings/presentation/manager/delete_account_cubit/delete_account_cubit.dart';
import 'package:bookly_app/features/settings/presentation/views/change_email_view.dart';
import 'package:bookly_app/features/settings/presentation/views/change_password_view.dart';
import 'package:bookly_app/features/settings/presentation/views/delete_account_view.dart';
import 'package:bookly_app/features/settings/presentation/views/settings_view.dart';
import 'package:bookly_app/features/splash/presentation/views/splash_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kRegisterView = '/registerView';
  static const kLoginView = '/loginView';
  static const kForgotPasswordView = '/forgotPasswordView';
  static const kHomeView = '/homeView';
  static const kBookDetailsView = '/bookDetailsView';
  static const kSearchView = '/searchView';
  static const kFavoriteView = '/favoriteView';
  static const kProfileView = '/profileView';
  static const kSettingsView = '/settingsView';
  static const kChangeEmailView = '/changeEmailView';
  static const kChangePasswordView = '/changePasswordView';
  static const kDeleteAccountView = '/deleteAccountView';
  static const kNotificationsView = '/notificationsView';

  static final navigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            _noTransitionPage(child: const SplashView()),
      ),

      GoRoute(
        path: kRegisterView,
        pageBuilder: (context, state) =>
            _noTransitionPage(child: const RegisterView()),
      ),

      GoRoute(
        path: kLoginView,
        pageBuilder: (context, state) =>
            _noTransitionPage(child: const LoginView()),
      ),

      GoRoute(
        path: kForgotPasswordView,
        pageBuilder: (context, state) =>
            _noTransitionPage(child: const ForgotPasswordView()),
      ),

      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) {
          return _noTransitionPage(
            child: MainView(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kHomeView,
                pageBuilder: (context, state) => _noTransitionPage(
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) =>
                            FeaturedBooksCubit(getIt<HomeRepo>())
                              ..fetchFeaturedBooks(),
                      ),
                      BlocProvider(
                        create: (context) =>
                            NewestBooksCubit(getIt<HomeRepo>())
                              ..fetchNewestBooks(),
                      ),
                    ],
                    child: const HomeView(),
                  ),
                ),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kSearchView,
                pageBuilder: (context, state) => _noTransitionPage(
                  child: BlocProvider(
                    create: (context) => SearchCubit(getIt<SearchRepo>()),
                    child: const SearchView(),
                  ),
                ),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kFavoriteView,
                pageBuilder: (context, state) =>
                    _noTransitionPage(child: const FavoriteView()),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kProfileView,
                pageBuilder: (context, state) => _noTransitionPage(
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => ProfileCubit(
                          profileRepo: getIt<ProfileRepo>(),
                          auth: getIt<FirebaseAuth>(),
                        )..fetchProfile(),
                      ),
                      BlocProvider(
                        create: (context) =>
                            NotificationSettingsCubit(getIt<NotificationRepo>())
                              ..getNotificationsEnabled(),
                      ),
                    ],
                    child: const ProfileView(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: kBookDetailsView,
        pageBuilder: (context, state) => _noTransitionPage(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SimilarBooksCubit(getIt<HomeRepo>()),
              ),
            ],
            child: BookDetailsView(bookModel: state.extra as BookModel),
          ),
        ),
      ),

      GoRoute(
        path: kSettingsView,
        pageBuilder: (context, state) =>
            _noTransitionPage(child: const SettingsView()),
      ),

      GoRoute(
        path: kChangeEmailView,
        pageBuilder: (context, state) => _noTransitionPage(
          child: BlocProvider(
            create: (context) => ChangeEmailCubit(getIt<AuthRepo>()),
            child: const ChangeEmailView(),
          ),
        ),
      ),

      GoRoute(
        path: kChangePasswordView,
        pageBuilder: (context, state) => _noTransitionPage(
          child: BlocProvider(
            create: (context) => ChangePasswordCubit(getIt<AuthRepo>()),
            child: const ChangePasswordView(),
          ),
        ),
      ),

      GoRoute(
        path: kDeleteAccountView,
        pageBuilder: (context, state) => _noTransitionPage(
          child: BlocProvider(
            create: (context) => DeleteAccountCubit(getIt<AuthRepo>()),
            child: const DeleteAccountView(),
          ),
        ),
      ),

      GoRoute(
        path: kNotificationsView,
        pageBuilder: (context, state) => _noTransitionPage(
          child: BlocProvider(
            create: (context) => NotificationCubit(getIt<NotificationRepo>())..fetchNotifications(),
            child: const NotificationsView(),
          ),
        ),
      ),
    ],
  );

  static Page<void> _noTransitionPage({required Widget child}) {
    return NoTransitionPage<void>(child: child);
  }

  static Future<void> openBookById(String bookId) async {
    final result = await getIt<HomeRepo>().fetchBookById(bookId);

    result.fold((failure) => null, (book) {
      final context = navigatorKey.currentContext;
      if (context == null) return;
      context.push(kBookDetailsView, extra: book);
    });
  }
}
