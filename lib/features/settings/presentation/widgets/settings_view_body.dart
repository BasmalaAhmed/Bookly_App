import 'package:bookly_app/core/theme/widgets/app_background.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/settings/presentation/widgets/theme_setting_item.dart';
import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}
