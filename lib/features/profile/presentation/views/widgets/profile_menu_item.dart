import 'package:bookly_app/core/theme/app_glass_theme.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.isLogOut = false,
  });

  final String title;
  final FaIconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool isLogOut;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final itemColor = iconColor ?? theme.colorScheme.onSurface;
    final borderColor = isDark
        ? const Color(0XFFA78BFA).withValues(alpha: 0.45)
        : const Color(0XFFA78BFA).withValues(alpha: 0.30);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: theme.colorScheme.onSurface.withValues(alpha: 0.08),
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: LiquidGlassLayer(
          settings: AppGlassTheme.settings(context),
          child: LiquidGlass(
            shape: LiquidRoundedRectangle(borderRadius: 16),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor, width: 0.8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    FaIcon(icon, color: itemColor, size: 20),
                    const SizedBox(width: 20),
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.textStyle16.copyWith(color: itemColor),
                    ),
                    const Spacer(),
                    (isLogOut)
                        ? const SizedBox.shrink()
                        : FaIcon(
                            FontAwesomeIcons.angleRight,
                            color: theme.colorScheme.onSurfaceVariant,
                            size: 16,
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
