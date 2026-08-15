import 'package:bookly_app/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ThemeSettingItem extends StatelessWidget {
  const ThemeSettingItem({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;

    final isDark = themeMode == ThemeMode.dark;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: FaIcon(
        isDark ? FontAwesomeIcons.moon : FontAwesomeIcons.circleHalfStroke,
      ),
      title: const Text('Dark Mode'),
      trailing: Switch(
        value: isDark,
        onChanged: (_) {
          context.read<ThemeCubit>().toggleTheme();
        },
      ),
    );
  }
}
