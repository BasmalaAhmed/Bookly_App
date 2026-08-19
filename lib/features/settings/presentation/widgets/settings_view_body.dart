import 'package:bookly_app/core/theme/widgets/app_background.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/profile_menu_item.dart';
import 'package:bookly_app/features/settings/presentation/widgets/theme_setting_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: Styles.textStyle30.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const ThemeSettingItem(),
            const SizedBox(height: 24),
            ProfileMenuItem(
              title: 'Change Email',
              icon: FontAwesomeIcons.envelope,
              onTap: () {
                context.push(AppRouter.kChangeEmailView);
              },
            ),
            const SizedBox(height: 24),
            ProfileMenuItem(
              title: 'Change Password',
              icon: FontAwesomeIcons.lock,
              onTap: () {
                context.push(AppRouter.kChangePasswordView);
              },
            ),
          ],
        ),
      ),
    );
  }
}
