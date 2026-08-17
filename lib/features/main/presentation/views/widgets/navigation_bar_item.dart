import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    super.key,
    required this.onTap,
    required this.icon,
    required this.isSelected,
    required this.label,
  });
  final VoidCallback onTap;
  final FaIconData icon;
  final String label;
  final bool isSelected;

  static const kNavAnimationDuration = Duration(milliseconds: 180);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: AnimatedContainer(
          duration: kNavAnimationDuration,
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected
                ? colorScheme.secondary.withValues(alpha: 0.18)
                : Colors.transparent,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 2,
                      color: colorScheme.secondary.withValues(alpha: 0.25),
                    ),
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                duration: kNavAnimationDuration,
                scale: isSelected ? 1.1 : 1,
                child: FaIcon(
                  icon,
                  color: isSelected ? Colors.white : colorScheme.outline,
                  size: isSelected ? 25 : 22,
                ),
              ),
              AnimatedCrossFade(
                duration: kNavAnimationDuration,
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    label,
                    style: Styles.textStyle12.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                crossFadeState: isSelected
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
