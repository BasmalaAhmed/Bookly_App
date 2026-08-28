import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/about/presentation/widgets/feature_item.dart';
import 'package:bookly_app/features/auth/presentation/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutViewBody extends StatelessWidget {
  const AboutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: Styles.textStyle30.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          Center(
            child: Column(
              children: [
                const LogoWidget(scale: 2),
                const SizedBox(height: 16),

                Text('Discover your next read.', style: Styles.textStyle16),
              ],
            ),
          ),
          const SizedBox(height: 36),
          Text(
            'About Bookly',
            style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Bookly is a modern book discovery app that helps you '
            'explore, search, and save your favorite books in one place.',
            style: Styles.textStyle16,
          ),
          const SizedBox(height: 32),
          Text(
            'Features',
            style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const FeatureItem(
            icon: FontAwesomeIcons.book,
            title: 'Discover Books',
          ),
          const FeatureItem(
            icon: FontAwesomeIcons.magnifyingGlass,
            title: 'Search Books',
          ),
          const FeatureItem(
            icon: FontAwesomeIcons.heart,
            title: 'Save Favorites',
          ),
          const FeatureItem(
            icon: FontAwesomeIcons.bell,
            title: 'Notifications',
          ),
          const SizedBox(height: 24),
          Text(
            'Built with',
            style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Flutter • Dart • Firebase • Google Books API',
            style: Styles.textStyle16,
          ),
          const SizedBox(height: 32),
          Center(child: Text('Version 1.0.0', style: Styles.textStyle14)),
        ],
      ),
    );
  }
}
