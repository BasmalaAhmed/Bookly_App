import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(AssetsData.logo, scale: 4),
        const Spacer(),
        IconButton(
          onPressed: () {
            context.push(AppRouter.kFavoriteView);
          },
          tooltip: 'Favorites',
          icon: const FaIcon(FontAwesomeIcons.heartCircleCheck, color: Colors.white, size : 24,),
        ),
        const SizedBox(width: 6,),
        IconButton(
          onPressed: () {
            context.push(AppRouter.kSearchView);
          },
          tooltip: 'Search',
          icon: const Icon(
            Icons.search_outlined,
            size: 30,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
