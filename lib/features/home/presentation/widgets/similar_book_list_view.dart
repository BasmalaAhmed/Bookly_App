import 'package:bookly_app/features/home/presentation/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';

class SimilarBookListView extends StatelessWidget {
  const SimilarBookListView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
            height: size.height * 0.2,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CustomBookImage(imageUrl: 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcSz2I0c_d8ZodmvN-m0Fosa9jj8v_m9uLpsvbtbvIOtY_6mxxItuwoTRETucn8oDHlyUJtH5WovlxzVfm6U9uZr7851WYlAuBcxn58bdc0Z&usqp=CAc',),
                );
              },
            ),
          );
  }
}