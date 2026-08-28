import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeatureItem extends StatelessWidget {
  const FeatureItem({super.key, required this.icon, required this.title});

  final FaIconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          FaIcon(
            icon, 
            size: 18, 
            color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 14),
          Text(
            title,
             style: Styles.textStyle16),
        ],
      ),
    );
  }
}
