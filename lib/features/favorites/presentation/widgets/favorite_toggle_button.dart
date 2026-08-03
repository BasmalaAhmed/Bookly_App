import 'package:bookly_app/features/favorites/presentation/manager/cubit/favorite_cubit.dart';
import 'package:bookly_app/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:bookly_app/features/home/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteToggleButton extends StatelessWidget {
  const FavoriteToggleButton({
    super.key,
    required this.width,
    required this.height,
    required this.size,
    required this.book,
  });
  final double width;
  final double height;
  final double size;
  final BookModel book;

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = context.watch<FavoriteCubit>();
    final isFavorite = favoriteCubit.isFavorite(book.id);
    return FavoriteButton(
      isFavorite: isFavorite,
      onPressed: () {
        favoriteCubit.toggleFavorite(book);
      },
      width: width,
      height: height,
      size: size,
    );
  }
}
