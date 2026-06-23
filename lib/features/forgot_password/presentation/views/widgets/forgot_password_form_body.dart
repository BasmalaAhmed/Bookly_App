import 'package:bookly_app/core/utils/validators.dart';
import 'package:bookly_app/core/utils/widgets/custom_button.dart';
import 'package:bookly_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:bookly_app/features/login/presentation/views/login_view.dart';
import 'package:bookly_app/core/utils/widgets/custom_redirect_text.dart';
import 'package:flutter/material.dart';

class ForgotPasswordFormBody extends StatefulWidget {
  const ForgotPasswordFormBody({super.key});

  @override
  State<ForgotPasswordFormBody> createState() => _ForgotPasswordFormBodyState();
}

class _ForgotPasswordFormBodyState extends State<ForgotPasswordFormBody> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.03,
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              hintText: 'Email',
              prefixIcon: Icons.mail_outlined,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              controller: emailController,
              validator: Validators.validateEmail,
            ),
            SizedBox(height: size.height * 0.03),
            CustomButton(
              label: 'Send Reset Link',
              onPressed: () {
                if (formKey.currentState!.validate()) {
    print('Send Reset Link');
  }
              },
            ),
            SizedBox(height: size.height * 0.03),
            CustomRedirectText(
              text: "Back To",
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
