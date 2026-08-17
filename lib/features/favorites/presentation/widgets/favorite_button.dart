import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.width,
    required this.height,
    required this.size,
    required this.isFavorite,
    this.onPressed,
  });

  final double width;
  final double height;
  final double size;
  final bool isFavorite;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LiquidGlassLayer(
      child: LiquidGlass(
        shape: LiquidOval(),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.4),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.outline.withValues(alpha: 0.6),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            padding: const EdgeInsets.all(2),
            onPressed: onPressed,
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutBack,
                  ),
                  child: RotationTransition(
                    turns: Tween<double>(
                      begin: 0.97,
                      end: 1,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: FaIcon(
                isFavorite
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                key: ValueKey(isFavorite),
                size: isFavorite ? size : size - 2,
                color: isFavorite ? Colors.red : colorScheme.onSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
