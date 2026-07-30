import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/widgets/custom_error_widget.dart';
import 'package:bookly_app/core/utils/widgets/loading_indicator.dart';
import 'package:bookly_app/features/home/presentation/widgets/book_list_view_item.dart';
import 'package:bookly_app/features/search/presentation/manager/cubit/search_cubit.dart';
import 'package:bookly_app/features/search/presentation/manager/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchFailure) {
          return CustomErrorMessage(errMessage: state.errMessage);
        } else if (state is SearchSuccess) {
          if (state.books.isEmpty) {
            return const Center(child: Text('No Books Found', style: Styles.textStyle16));
          }
          return ListView.builder(
            padding: EdgeInsets.zero,

            itemCount: state.books.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: BookListViewItem(bookModel: state.books[index]),
              );
            },
          );
        } else if (state is SearchInitial) {
          return const Center(child: Text('Search for a book...', style: Styles.textStyle16));
        } else {
          return const Center(child: LoadingIndicator());
        }
      },
    );
  }
}
