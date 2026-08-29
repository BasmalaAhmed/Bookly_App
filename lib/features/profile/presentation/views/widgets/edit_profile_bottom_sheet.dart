import 'dart:io';

import 'package:bookly_app/core/utils/validators.dart';
import 'package:bookly_app/core/utils/widgets/custom_button.dart';
import 'package:bookly_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:bookly_app/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/draggable_handle.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/edit_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({super.key, required this.name});

  final String name;

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.name;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.75,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.2)
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
                      prefixIcon: FontAwesomeIcons.user,
                      textInputAction: TextInputAction.done,
                      controller: _nameController,
                      validator: Validators.validateUsername,
                    ),
                    const SizedBox(height: 32),
                    CustomButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        await profileCubit.updateProfile(
                          name: _nameController.text.trim(),
                        );

                        if (context.mounted) {
                          Navigator.pop(context, _selectedImage);
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
