import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileImage extends StatefulWidget {
  const EditProfileImage({super.key, required this.onImageSelected});

  final void Function(File image) onImageSelected;

  @override
  State<EditProfileImage> createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return;

    final image = File(pickedImage.path);

    setState(() {
      _selectedImage = image;
    });

    widget.onImageSelected(image);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundImage: _selectedImage != null
              ? FileImage(_selectedImage!)
              : const AssetImage('assets/images/Avatar_Placeholder.jpeg'),
        ),
        Positioned(
          bottom: 4,
          right: 4,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.secondary,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 1.5,
                    color: colorScheme.shadow,
                  ),
                ],
              ),
              child: const Center(
                child: FaIcon(FontAwesomeIcons.penFancy, size: 16, color: Colors.white,),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
