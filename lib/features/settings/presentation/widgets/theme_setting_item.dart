import 'package:bookly_app/core/theme/theme_cubit.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/settings/presentation/widgets/theme_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ThemeAppearance { light, dark, system }

class ThemeSettingItem extends StatelessWidget {
  const ThemeSettingItem({super.key});

  ThemeAppearance _appearanceFromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return ThemeAppearance.light;
      case ThemeMode.dark:
        return ThemeAppearance.dark;
      case ThemeMode.system:
        return ThemeAppearance.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final selectedAppearance = _appearanceFromThemeMode(themeMode);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Appearance', style: Styles.textStyle18),
        ThemeOptionTile(
          title: 'Light',
          icon: FontAwesomeIcons.circleHalfStroke,
          isSelected: selectedAppearance == ThemeAppearance.light,
          onTap: () {
            context.read<ThemeCubit>().setTheme(ThemeMode.light);
          },
        ),
        ThemeOptionTile(
          title: 'Dark',
          icon: FontAwesomeIcons.moon,
          isSelected: selectedAppearance == ThemeAppearance.dark,
          onTap: () {
            context.read<ThemeCubit>().setTheme(ThemeMode.dark);
          },
        ),
        ThemeOptionTile(
          title: 'System',
          icon: FontAwesomeIcons.gear,
          isSelected: selectedAppearance == ThemeAppearance.system,
          onTap: () {
            context.read<ThemeCubit>().setTheme(ThemeMode.system);
          },
        ),
      ],
    );
  }
}
