import 'package:bookly_app/features/auth/presentation/widgets/register_view_body.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  static String id = 'RegisterView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: RegisterViewBody()),
    );
  }
}