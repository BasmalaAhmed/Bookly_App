import 'package:bookly_app/features/auth/presentation/views/forgot_password_view.dart';
import 'package:bookly_app/features/auth/presentation/views/login_view.dart';
import 'package:bookly_app/features/auth/presentation/views/register_view.dart';
import 'package:bookly_app/features/home/presentation/views/book_details_view.dart';
import 'package:bookly_app/features/home/presentation/views/home_view.dart';
import 'package:bookly_app/features/search/presentation/views/search_view.dart';
import 'package:bookly_app/features/splash/presentation/views/splash_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kRegisterView = '/registerView';
  static const kLoginView = '/loginView';
  static const kForgotPasswordView = '/forgotPasswordView';
  static const kHomeView = '/homeView';
  static const kBookDetailsView = '/bookDetailsView';
  static const kSearchView = '/searchView';
  static final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashView(),
    ),

    GoRoute(
      path: kRegisterView,
      builder: (context, state) => RegisterView(),
    ),

    GoRoute(
      path: kLoginView,
      builder: (context, state) => LoginView(),
    ),

    GoRoute(
      path: kForgotPasswordView,
      builder: (context, state) => ForgotPasswordView(),
    ),

    GoRoute(
      path: kHomeView,
      builder: (context, state) => HomeView(),
    ),

    GoRoute(
      path: kBookDetailsView,
      builder: (context, state) => BookDetailsView(),
    ),

    GoRoute(
      path: kSearchView,
      builder: (context, state) => SearchView(),
    ),
  ],
);
}