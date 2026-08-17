import 'dart:io';

import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.image,
  });

  final String name;
  final String email;
  final File? image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: image != null
              ? FileImage(image!)
              : const AssetImage('assets/images/Avatar_Placeholder.jpeg'),
        ),
        const SizedBox(width: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(email, style: Styles.textStyle14),
          ],
        ),
      ],
    );
  }
}
