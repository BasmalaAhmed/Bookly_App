import 'package:bookly_app/core/utils/assets.dart';
import 'package:bookly_app/features/login/presentation/views/widgets/login_form_body.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.15),
      child: Center(
        child: Column(
          children: [
            Image.asset(AssetsData.logo, scale: 1.5),
            SizedBox(
              height: size.height * 0.12,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
              child: Stack(
                children: [
                  LiquidGlassLayer(
                    child: LiquidGlass(
                      shape: LiquidRoundedRectangle(borderRadius: 12),
                      child: LoginFormBody(),
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
