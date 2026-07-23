import 'package:bookly_app/core/utils/assets.dart';
import 'package:bookly_app/features/auth/presentation/widgets/register_form_body.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.15,),
          Image.asset(AssetsData.logo, scale: 1.1),
          SizedBox(
            height: size.height * 0.12,
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: LiquidGlassLayer(
              child: LiquidGlass(
                shape: LiquidRoundedRectangle(borderRadius: 12),
                child: const RegisterFormBody(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
