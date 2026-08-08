import 'dart:io';

import 'package:bookly_app/constants.dart';
import 'package:bookly_app/core/utils/validators.dart';
import 'package:bookly_app/core/utils/widgets/custom_button.dart';
import 'package:bookly_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/draggable_handle.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/edit_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({
    super.key,
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.name;
    _emailController.text = widget.email;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const DraggableHandle(),
                    const SizedBox(height: 20),
                    EditProfileImage(
                      onImageSelected: (image) {
                        _selectedImage = image;
                      },
                    ),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                      hintText: 'Enter Your Name',
                      prefixIcon: Icons.person,
                      textInputAction: TextInputAction.next,
                      controller: _nameController,
                      validator: Validators.validateUsername,
                    ),
                    const SizedBox(height: 18),
                    CustomTextFormField(
                      hintText: 'Enter Your Email',
                      prefixIcon: Icons.email,
                      textInputAction: TextInputAction.done,
                      controller: _emailController,
                      validator: Validators.validateEmail,
                    ),
                    const SizedBox(height: 32),
                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context, (
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            image: _selectedImage,
                          ));
                        }
                      },
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
