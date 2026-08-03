import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/favorites/presentation/manager/cubit/favorite_cubit.dart';
import 'package:bookly_app/features/favorites/presentation/manager/cubit/favorite_state.dart';
import 'package:bookly_app/features/favorites/presentation/widgets/favorite_books_list_view.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteViewBody extends StatelessWidget {
  const FavoriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(),
                const SizedBox(height: 18),
                Text(
                  'My Favorite Books',
                  style: Styles.textStyle30.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    if (state is FavoriteSuccess) {
                      final count = state.books.length;
                      return Text(
                        '$count ${count == 1 ? 'Book' : 'Books'}',
                        style: Styles.textStyle16,
                      );
                    }
                    if (state is FavoriteLoading) {
                      return const Text('Loading...');
                    }
                    return Text('0 Books', style: Styles.textStyle16);
                  },
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
          const FavoriteBooksListView(),
        ],
      ),
    );
  }
}