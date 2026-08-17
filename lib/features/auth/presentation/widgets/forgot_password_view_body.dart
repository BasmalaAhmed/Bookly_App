import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/auth/presentation/widgets/forgot_password_form_body.dart';
import 'package:bookly_app/features/auth/presentation/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.15),
          const LogoWidget(scale: 1.4,),
          SizedBox(height: size.height * 0.06),
          Text(
            'Forgot Password?',
            style: Styles.textStyle30.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Enter your email address and we'll send you a password reset link.",
              textAlign: TextAlign.center,
              style: Styles.textStyle14.copyWith(color: Colors.grey),
            ),
          ),
          SizedBox(height: size.height * 0.04),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: LiquidGlassLayer(
              child: LiquidGlass(
                shape: LiquidRoundedRectangle(borderRadius: 12),
                child: const ForgotPasswordFormBody(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
