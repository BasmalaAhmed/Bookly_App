import 'package:bookly_app/features/auth/presentation/widgets/forgot_password_view_body.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  static String id = 'ForgotPasswordView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: ForgotPasswordViewBody()),
    );
  }
}