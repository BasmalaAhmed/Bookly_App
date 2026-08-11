import 'package:bookly_app/core/utils/service_locator.dart';
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
import 'package:bookly_app/features/splash/presentation/views/splash_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),

      GoRoute(
        path: kRegisterView,
        builder: (context, state) => const RegisterView(),
      ),

      GoRoute(path: kLoginView, builder: (context, state) => const LoginView()),

      GoRoute(
        path: kForgotPasswordView,
        builder: (context, state) => const ForgotPasswordView(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kHomeView,
                builder: (context, state) => MultiBlocProvider(
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
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kSearchView,
                builder: (context, state) => BlocProvider(
                  create: (context) => SearchCubit(getIt<SearchRepo>()),
                  child: const SearchView(),
                ),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kFavoriteView,
                builder: (context, state) => const FavoriteView(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kProfileView,
                builder: (context, state) => BlocProvider(
                  create: (context) => ProfileCubit(
                    profileRepo: getIt<ProfileRepo>(),
                    auth: getIt<FirebaseAuth>(),
                  )..fetchProfile(),
                  child: const ProfileView(),
                ),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: kBookDetailsView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SimilarBooksCubit(getIt<HomeRepo>()),
            ),
          ],
          child: BookDetailsView(bookModel: state.extra as BookModel),
        ),
      ),
    ],
  );
}
