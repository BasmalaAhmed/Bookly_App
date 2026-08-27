import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/features/auth/presentation/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LogoWidget(scale: 4,),
        const Spacer(flex: 12,),
        IconButton(
          onPressed: () {
            context.push(AppRouter.kNotificationsView);
          },
          tooltip: 'Notifications',
          icon: const FaIcon(FontAwesomeIcons.solidBell, size: 20),
        ),
        const Spacer(flex: 1,),
        IconButton(
          onPressed: () {},
          tooltip: 'Cart',
          icon: const FaIcon(FontAwesomeIcons.cartShopping, size: 20),
        ),
      ],
    );
  }
}
