import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/widgets/loading_indicator.dart';
import 'package:bookly_app/features/notifications/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:bookly_app/features/notifications/presentation/manager/notification_cubit/notification_state.dart';
import 'package:bookly_app/features/notifications/presentation/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsViewBody extends StatelessWidget {
  const NotificationsViewBody({super.key});

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
                const SizedBox(height: 18),
                Text(
                  'Notifications',
                  style: Styles.textStyle30.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                    if (state is NotificationSuccess) {
                      final count = state.notifications.length;

                      return Text(
                        '$count ${count == 1 ? 'Notification' : 'Notifications'}',
                        style: Styles.textStyle16.copyWith(color: Colors.grey),
                      );
                    }

                    if (state is NotificationLoading) {
                      return const Text('Loading...');
                    }

                    return const Text('0 Notifications');
                  },
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),

          BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoading) {
                return const SliverFillRemaining(
                  child: Center(child: LoadingIndicator()),
                );
              }

              if (state is NotificationSuccess) {
                if (state.notifications.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No Notifications Yet')),
                  );
                }

                return SliverList.builder(
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = state.notifications[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: NotificationItem(notification: notification, 
                      onTap: () async {
                        if(!notification.isRead){
                          context.read<NotificationCubit>().markAsRead(notification.id);
                        }

                        final bookId = notification.bookId;
                        
                        if(bookId != null && bookId.isNotEmpty){
                          await AppRouter.openBookById(bookId);
                        }
                      },),
                    );
                  },
                );
              }

              if (state is NotificationFailure) {
                return SliverFillRemaining(
                  child: Center(child: Text(state.errMessage)),
                );
              }

              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 18)),
        ],
      ),
    );
  }
}
