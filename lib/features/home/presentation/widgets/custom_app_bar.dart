import 'package:bookly_app/features/auth/presentation/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LogoWidget(scale: 4,),
        const Spacer(),
        IconButton(
          onPressed: () {},
          tooltip: 'Cart',
          icon: const FaIcon(FontAwesomeIcons.cartShopping, size: 20),
        ),
      ],
    );
  }
}
