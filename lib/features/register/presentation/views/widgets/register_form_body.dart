import 'package:bookly_app/core/utils/widgets/custom_button.dart';
import 'package:bookly_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:bookly_app/features/register/presentation/views/widgets/custom_redirect_text.dart';
import 'package:flutter/material.dart';

class RegisterFormBody extends StatelessWidget {
  const RegisterFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: size.height * 0.02),
      child: Column(
        children: [
          CustomTextFormField(
            hintText: 'Username',
            prefixIcon: Icons.person_2_outlined,
            textInputAction: TextInputAction.next,
          ),
          CustomTextFormField(
            hintText: 'Email',
            prefixIcon: Icons.mail_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          CustomTextFormField(
            hintText: 'Password',
            prefixIcon: Icons.lock_outlined,
            isPassword: true,
            textInputAction: TextInputAction.next,
          ),
          CustomTextFormField(
            hintText: 'Confirm Password',
            prefixIcon: Icons.lock_outlined,
            isPassword: true,
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: size.height * 0.035),
          CustomButton(label: 'Register'),
          SizedBox(height: size.height * 0.03),
          CustomRedirectText(text: 'Already have an account?', textButton: 'Login',)
        ],
      ),
    );
  }
}


