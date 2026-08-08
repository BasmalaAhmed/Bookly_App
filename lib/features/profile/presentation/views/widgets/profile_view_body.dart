import 'dart:io';

import 'package:bookly_app/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/profile_menu_section.dart';
import 'package:flutter/material.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({
    super.key,
  });

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  String _name = 'Name';
  String _email = 'Email';
  File? _profileImage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        children: [
          ProfileHeader(name: _name, email: _email, image: _profileImage),
          const SizedBox(height: 18),
          Divider(color: Colors.white.withValues(alpha: 0.18)),
          const SizedBox(height: 24),
          ProfileMenuSection(
            name: _name,
            email: _email,
            onProfileUpdated: ({required name, required email, image}) {
              setState(() {
                _name = name;
                _email = email;
                if (image != null) {
                  _profileImage = image;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
