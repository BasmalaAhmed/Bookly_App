import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ThemeSettingItemIcon extends StatelessWidget {
  const ThemeSettingItemIcon({
    super.key,
    required this.isSelected,
    required this.selectedIcon,
  });

  final bool isSelected;
  final FaIconData selectedIcon;

  @override
  Widget build(BuildContext context) {
    return FaIcon(
      selectedIcon,
      size: 22,
      color: isSelected
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.onSurfaceVariant,
    );
  }
}
