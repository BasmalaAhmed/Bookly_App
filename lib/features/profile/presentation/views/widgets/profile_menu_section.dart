import 'package:bookly_app/features/profile/presentation/views/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key});


  @override
  Widget build(BuildContext context) {
    const menuItems = [
      (title: 'Edit Profile', icon: FontAwesomeIcons.solidUser),
      (title: 'Notifications', icon: FontAwesomeIcons.solidBell),
      (title: 'Settings', icon: FontAwesomeIcons.gear),
      (title: 'About', icon: FontAwesomeIcons.circleInfo),
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
              onTap: () {},
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
