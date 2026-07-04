import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/home/presentation/widgets/best_seller_list_view.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:bookly_app/features/home/presentation/widgets/featured_books_list_view.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(),
                const SizedBox(height: 18,),
                const FeaturedBooksListView(),
                const SizedBox(height: 42,),
                Text('Best Seller' , style: Styles.textStyle18,),
              ],
            ),
          ),
      
          SliverFillRemaining(
            child: const BestSellerListView(),
          )
        ],
      ),
    );
  }
}
