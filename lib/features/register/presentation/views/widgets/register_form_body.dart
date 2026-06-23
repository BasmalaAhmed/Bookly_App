import 'package:bookly_app/core/utils/validators.dart';
import 'package:bookly_app/core/utils/widgets/custom_button.dart';
import 'package:bookly_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:bookly_app/features/login/presentation/views/login_view.dart';
import 'package:bookly_app/core/utils/widgets/custom_redirect_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterFormBody extends StatefulWidget {
  const RegisterFormBody({super.key});

  @override
  State<RegisterFormBody> createState() => _RegisterFormBodyState();
}

class _RegisterFormBodyState extends State<RegisterFormBody> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
              hintText: 'Username',
              prefixIcon: Icons.person_2_outlined,
              textInputAction: TextInputAction.next,
              controller: usernameController,
              validator: Validators.validateUsername,
            ),
            CustomTextFormField(
              hintText: 'Email',
              prefixIcon: Icons.mail_outlined,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: emailController,
              validator: Validators.validateEmail,
            ),
            CustomTextFormField(
              hintText: 'Password',
              prefixIcon: Icons.lock_outlined,
              isPassword: true,
              textInputAction: TextInputAction.next,
              controller: passwordController,
              validator: Validators.validatePassword,
            ),
            CustomTextFormField(
              hintText: 'Confirm Password',
              prefixIcon: Icons.lock_outlined,
              isPassword: true,
              textInputAction: TextInputAction.done,
              controller: confirmPasswordController,
              validator: (value) {
                return Validators.validateConfirmPassword(
                  value,
                  passwordController.text,
                );
              },
            ),
            SizedBox(height: size.height * 0.035),
            CustomButton(
              label: 'Register',
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User Created Successfully')),
                    );
                    Future.delayed(Duration(seconds: 2));
                    Navigator.pushReplacementNamed(context, LoginView.id);
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.code)));
                  }
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            CustomRedirectText(
              text: 'Already have an account?',
              textButton: 'Login',
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginView.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
