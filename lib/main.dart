import 'package:bookly_app/constants.dart';
import 'package:bookly_app/features/login/presentation/views/login_view.dart';
import 'package:bookly_app/features/register/presentation/views/register_view.dart';
import 'package:bookly_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BooklyApp());
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      routes: {
        'RegisterView' : (context) => RegisterView(),
        'LoginView' : (context) => LoginView(),
      },
      home: const SplashView(),
    );
  }
}
