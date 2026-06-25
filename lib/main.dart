import 'package:bookly_app/constants.dart';
import 'package:bookly_app/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/features/auth/presentation/views/forgot_password_view.dart';
import 'package:bookly_app/features/auth/presentation/views/login_view.dart';
import 'package:bookly_app/features/auth/presentation/views/register_view.dart';
import 'package:bookly_app/features/splash/presentation/views/splash_view.dart';
import 'package:bookly_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const BooklyApp());
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers : [
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kBackgroundColor,
        ),
        routes: {
          'RegisterView': (context) => RegisterView(),
          'LoginView': (context) => LoginView(),
          'ForgotPasswordView': (context) => ForgotPasswordView(),
        },
        home: const SplashView(),
      ),
    );
  }
}
