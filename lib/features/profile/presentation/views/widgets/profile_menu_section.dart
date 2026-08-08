import 'dart:io';

import 'package:bookly_app/features/profile/presentation/views/widgets/edit_profile_bottom_sheet.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({
    super.key,
    required this.name,
    required this.email,
    required this.onProfileUpdated,
  });

  final String name;
  final String email;
  final void Function({
    required String name,
    required String email,
    File? image,
  })
  onProfileUpdated;

  @override
  Widget build(BuildContext context) {
    const menuItems = [
      (title: 'Edit Profile', icon: FontAwesomeIcons.solidUser, action: 'edit'),
      (
        title: 'Notifications',
        icon: FontAwesomeIcons.solidBell,
        action: 'notifications',
      ),
      (title: 'Settings', icon: FontAwesomeIcons.gear, action: 'settings'),
      (title: 'About', icon: FontAwesomeIcons.circleInfo, action: 'about'),
    ];
    return Column(
      children: [
        ...List.generate(menuItems.length, (index) {
          final item = menuItems[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: ProfileMenuItem(
              title: item.title,
              icon: item.icon,
              onTap: () async {
                switch (item.action) {
                  case 'edit':
                    final result =
                        await showModalBottomSheet<
                          ({String name, String email, File? image})
                        >(
                          context: context,
                          sheetAnimationStyle: AnimationStyle(
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          ),
                          useRootNavigator: true,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) =>
                              EditProfileBottomSheet(name: name, email: email),
                        );

                    if (result != null) {
                      onProfileUpdated(
                        name: result.name,
                        email: result.email,
                        image: result.image,
                      );
                    }

                    break;

                  case 'notifications':
                    break;

                  case 'settings':
                    break;

                  case 'about':
                    break;
                }
              },
            ),
          );
        }),
        ProfileMenuItem(
          title: 'Logout',
          isLogOut: true,
          icon: FontAwesomeIcons.anglesLeft,
          iconColor: Colors.redAccent,
          onTap: () {},
        ),
      ],
    );
  }
}
