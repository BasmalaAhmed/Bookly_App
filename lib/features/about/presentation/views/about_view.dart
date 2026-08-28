import 'package:bookly_app/features/about/presentation/widgets/about_view_body.dart';
import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: AboutViewBody()));
  }
}
