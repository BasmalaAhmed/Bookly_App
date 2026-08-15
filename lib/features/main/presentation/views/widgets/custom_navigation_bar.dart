import 'package:bookly_app/features/main/presentation/views/widgets/navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    const navigationItems = [
      (FontAwesomeIcons.solidHouse, 'Home'),
      (FontAwesomeIcons.magnifyingGlass, 'Search'),
      (FontAwesomeIcons.solidHeart, 'Favorites'),
      (FontAwesomeIcons.solidUser, 'Profile'),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: LiquidGlassLayer(
        child: LiquidGlass(
          shape: LiquidRoundedRectangle(borderRadius: 30),
          child: SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(navigationItems.length, (index) {
                  return NavigationBarItem(
                    onTap: () => onDestinationSelected(index),
                    icon: navigationItems[index].$1,
                    isSelected: currentIndex == index,
                    label: navigationItems[index].$2,
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
