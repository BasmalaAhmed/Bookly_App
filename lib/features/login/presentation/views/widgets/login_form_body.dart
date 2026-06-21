import 'package:bookly_app/core/utils/widgets/custom_button.dart';
import 'package:bookly_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:bookly_app/features/register/presentation/views/register_view.dart';
import 'package:bookly_app/features/register/presentation/views/widgets/custom_redirect_text.dart';
import 'package:flutter/material.dart';

class LoginFormBody extends StatelessWidget {
  const LoginFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: size.height * 0.02),
      child: Column(
        children: [
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
          SizedBox(height: size.height * 0.035),
          CustomButton(label: 'Login', onPressed: () {  },),
          SizedBox(height: size.height * 0.03),
          CustomRedirectText(text: "Don't have an account?", textButton: 'Register', onPressed: () { Navigator.popAndPushNamed(context, RegisterView.id); },)
        ],
      ),
    );
  }
}


