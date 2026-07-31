import 'package:bookly_app/constants.dart';
import 'package:bookly_app/features/favorites/presentation/manager/cubit/favorite_cubit.dart';
import 'package:bookly_app/features/home/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    required this.book,
    required this.width,
    required this.height,
    required this.size,
  });

  final BookModel book;
  final double width;
  final double height;
  final double size;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;
  bool _isProcessing = false;

  Future<void> _loadFavoriteStatus() async {
    final favorite = await context.read<FavoriteCubit>().isFavorite(
      widget.book.id,
    );
    if (!mounted) return;

    setState(() {
      _isFavorite = favorite;
    });
  }

  Future<void> _toggleFavorite() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);
    try {
      if (_isFavorite) {
        await context.read<FavoriteCubit>().removeFavorite(widget.book.id);
      } else {
        await context.read<FavoriteCubit>().addFavorite(widget.book);
      }

      if (!mounted) return;
      setState(() {
        _isFavorite = !_isFavorite;
      });
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  @override
  Widget build(BuildContext context) {
    return LiquidGlassLayer(
      child: LiquidGlass(
        shape: LiquidOval(),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: kBackgroundColor.withValues(alpha: 0.4),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: kFocusedBorderColor.withValues(alpha: 0.2),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            padding: EdgeInsets.all(2),
            onPressed: _isProcessing ? null : _toggleFavorite,
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutBack,
                  ),
                  child: RotationTransition(
                    turns: Tween<double>(begin: 0.97, end: 1).animate(animation),
                    child: child,
                  ),
                );
              },
              child: FaIcon(
                _isFavorite
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                key: ValueKey(_isFavorite),
                size: _isFavorite ? widget.size : widget.size - 2,
                color: _isFavorite ? Colors.red : kFocusedBorderColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
