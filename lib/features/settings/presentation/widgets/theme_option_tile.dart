import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/settings/presentation/widgets/theme_setting_item_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ThemeOptionTile extends StatelessWidget {
  const ThemeOptionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final FaIconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: isSelected
            ? theme.colorScheme.primary.withValues(alpha: 0.10)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: ThemeSettingItemIcon(
          isSelected: isSelected,
          selectedIcon: icon,
        ),
        title: Text(
          title,
          style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w500),
        ),
        trailing: isSelected
            ? FaIcon(
                FontAwesomeIcons.circleCheck,
                color: theme.colorScheme.primary,
                size: 20,
              )
            : null,
      ),
    );
  }
}
