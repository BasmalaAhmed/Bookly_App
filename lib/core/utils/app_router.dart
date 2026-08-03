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
import 'package:bookly_app/features/search/data/repos/search_repo.dart';
import 'package:bookly_app/features/search/presentation/manager/cubit/search_cubit.dart';
import 'package:bookly_app/features/search/presentation/views/search_view.dart';
import 'package:bookly_app/features/splash/presentation/views/splash_view.dart';
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

      GoRoute(
        path: kHomeView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  FeaturedBooksCubit(getIt<HomeRepo>())..fetchFeaturedBooks(),
            ),
            BlocProvider(
              create: (context) =>
                  NewestBooksCubit(getIt<HomeRepo>())..fetchNewestBooks(),
            ),
          ],
          child: const HomeView(),
        ),
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

      GoRoute(
        path: kSearchView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => SearchCubit(getIt<SearchRepo>())),
          ],
          child: const SearchView(),
        ),
      ),
      GoRoute(
        path: kFavoriteView,
        builder: (context, state) => const FavoriteView(),
        ),
    ],
  );
}
