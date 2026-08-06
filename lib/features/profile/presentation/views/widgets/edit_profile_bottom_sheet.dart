import 'package:bookly_app/constants.dart';
import 'package:bookly_app/core/utils/widgets/custom_button.dart';
import 'package:bookly_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/draggable_handle.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/edit_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class EditProfileBottomSheet extends StatelessWidget {
  const EditProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.75,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2A0A47), kBackgroundColor],
        ),
      ),
      child: LiquidGlassLayer(
        child: LiquidGlass(
          shape: LiquidRoundedRectangle(borderRadius: 30),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              18,
              24,
              32 + MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DraggableHandle(),
                  const SizedBox(height: 20),
                  const EditProfileImage(),
                  const SizedBox(height: 24),
                  CustomTextFormField(
                    hintText: 'Enter Your Name',
                    prefixIcon: Icons.person,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 18),
                  CustomTextFormField(
                    hintText: 'Enter Your Email',
                    prefixIcon: Icons.email,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    onPressed: () {},
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
