import 'package:bookly_app/core/utils/widgets/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            ? const Center(child: FaIcon(FontAwesomeIcons.bookOpen, size: 50, color: Colors.grey,))
            : CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                    const Center(child: LoadingIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: FaIcon(FontAwesomeIcons.bookOpen, size: 40, color: Colors.grey,)),
              ),
      ),
    );
  }
}
