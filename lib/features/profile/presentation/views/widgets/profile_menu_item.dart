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
    final itemColor = iconColor ?? Colors.white;
    final backgroundColor = Colors.white.withValues(alpha: 0.02);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.white.withValues(alpha: .08),
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: LiquidGlassLayer(
          child: LiquidGlass(
            shape: LiquidRoundedRectangle(borderRadius: 16),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    FaIcon(icon, color: iconColor, size: 20),
                    const SizedBox(width: 20),
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.textStyle16.copyWith(color: itemColor),
                    ),
                    const Spacer(),
                    (isLogOut)
                        ? const SizedBox.shrink()
                        : const FaIcon(
                            FontAwesomeIcons.angleRight,
                            size: 16,
                            color: Colors.white54,
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
