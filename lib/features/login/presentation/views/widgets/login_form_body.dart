import 'package:bookly_app/core/utils/widgets/custom_button.dart';
import 'package:bookly_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:bookly_app/features/register/presentation/views/register_view.dart';
import 'package:bookly_app/features/register/presentation/views/widgets/custom_redirect_text.dart';
import 'package:flutter/material.dart';

class LoginFormBody extends StatefulWidget {
  const LoginFormBody({super.key});

  @override
  State<LoginFormBody> createState() => _LoginFormBodyState();
}

class _LoginFormBodyState extends State<LoginFormBody> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.02,
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              hintText: 'Email',
              prefixIcon: Icons.mail_outlined,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: emailController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                if (!value.contains('@')) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            CustomTextFormField(
              hintText: 'Password',
              prefixIcon: Icons.lock_outlined,
              isPassword: true,
              textInputAction: TextInputAction.next,
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            SizedBox(height: size.height * 0.035),
            CustomButton(
              label: 'Login',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  print('Login Form Valid');
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            CustomRedirectText(
              text: "Don't have an account?",
              textButton: 'Register',
              onPressed: () {
                Navigator.popAndPushNamed(context, RegisterView.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
