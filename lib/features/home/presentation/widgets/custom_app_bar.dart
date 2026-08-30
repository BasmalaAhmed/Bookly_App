import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/features/auth/presentation/widgets/logo_widget.dart';
import 'package:bookly_app/features/notifications/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:bookly_app/features/notifications/presentation/manager/notification_cubit/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LogoWidget(scale: 4),
        const Spacer(),
        BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            final unreadCount = state is NotificationSuccess
                ? state.unreadCount
                : 0;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () {
                    context.push(AppRouter.kNotificationsView);
                  },
                  tooltip: 'Notifications',
                  icon: const FaIcon(FontAwesomeIcons.solidBell, size: 20),
                ),
                if (unreadCount > 0)
                  Positioned(
                    right: 8,
                    top: 6,
                    width: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 1,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        unreadCount > 9 ? '9+' : '$unreadCount',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
