import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBookDetailsAppBar extends StatelessWidget {
  const CustomBookDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            context.pop();
          },
          tooltip: 'Close',
          icon: const Icon(Icons.close_outlined, color: Colors.white),
        ),
        IconButton(
          onPressed: () {},
          tooltip: 'Cart',
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
        ),
      ],
    );
  }
}
