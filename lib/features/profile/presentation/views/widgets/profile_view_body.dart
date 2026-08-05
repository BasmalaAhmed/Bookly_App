import 'package:bookly_app/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/profile_menu_section.dart';
import 'package:flutter/material.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        children: [
          const ProfileHeader(),
          const SizedBox(height: 18),
          Divider(color: Colors.white.withValues(alpha: 0.18)),
          const SizedBox(height: 24),
          const ProfileMenuSection(),
        ],
      ),
    );
  }
}
