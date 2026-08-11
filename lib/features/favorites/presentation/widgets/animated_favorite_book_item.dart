import 'package:bookly_app/features/favorites/presentation/manager/cubit/favorite_cubit.dart';
import 'package:bookly_app/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:bookly_app/features/home/data/models/book_model.dart';
import 'package:bookly_app/features/home/presentation/widgets/book_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedFavoriteBookItem extends StatefulWidget {
  const AnimatedFavoriteBookItem({super.key, required this.book});

  final BookModel book;

  @override
  State<AnimatedFavoriteBookItem> createState() =>
      _AnimatedFavoriteBookItemState();
}

class _AnimatedFavoriteBookItemState extends State<AnimatedFavoriteBookItem> {
  bool _isRemoving = false;
  static const _animationDuration = Duration(milliseconds: 250);

  Future<void> _removeBook() async {
    setState(() {
      _isRemoving = true;
    });

    await Future.delayed(_animationDuration);

    if (!mounted) return;

    context.read<FavoriteCubit>().removeFavorite(widget.book.id);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isRemoving ? 0 : 1,
      duration: _animationDuration,
      curve: Curves.easeInOut,
      child: AnimatedScale(
        scale: _isRemoving ? 0.8 : 1,
        duration: _animationDuration,
        curve: Curves.easeInOut,
        child: BookListViewItem(
          book: widget.book,
          favoriteButton: FavoriteButton(
            width: 26,
            height: 26,
            size: 14,
            isFavorite: true,
            onPressed: _removeBook,
          ),
        ),
      ),
    );
  }
}
