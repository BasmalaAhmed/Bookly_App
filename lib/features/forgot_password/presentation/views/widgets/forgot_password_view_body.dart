import 'package:bookly_app/constants.dart';
import 'package:bookly_app/core/utils/assets.dart';
import 'package:bookly_app/features/forgot_password/presentation/views/widgets/forgot_password_form_body.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.15),
      child: Center(
        child: Column(
          children: [
            Image.asset(AssetsData.logo, scale: 2),
            SizedBox(
              height: size.height * 0.06,
            ),
            Text(
      'Forgot Password?',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
              child: Text(
                      "Enter your email and we'll send you a password reset link.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kHintTextColor,
                        fontSize: 14,
                      ),
                    ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
              child: Stack(
                children: [
                  LiquidGlassLayer(
                    child: LiquidGlass(
                      shape: LiquidRoundedRectangle(borderRadius: 12),
                      child: ForgotPasswordFormBody(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}