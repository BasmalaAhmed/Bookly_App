import 'package:bookly_app/core/utils/widgets/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomBookImage extends StatelessWidget {
  const CustomBookImage({super.key, required this.imageUrl, this.aspectRatio = 2.6 / 4});
  final String? imageUrl; 
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: imageUrl == null || imageUrl!.isEmpty
            ? const Center(child: Icon(Icons.menu_book_outlined, size: 50, color: Colors.grey,))
            : CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: LoadingIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.broken_image_outlined, size: 40, color: Colors.grey,)),
              ),
      ),
    );
  }
}
