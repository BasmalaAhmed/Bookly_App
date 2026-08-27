import 'package:bookly_app/core/utils/date_formatter.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/notifications/data/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final isRead = notification.isRead;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.onSurfaceVariant.withValues(alpha: isRead ? 0.08 : 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.onSurfaceVariant.withValues(alpha: isRead ? 0.08 : 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FaIcon(
            FontAwesomeIcons.bell,
            size: 26,
            color: isRead
                ? Theme.of(context).colorScheme.onSurfaceVariant
                : Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: Styles.textStyle16.copyWith(
                    fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notification.message,
                  style: Styles.textStyle14.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  DateFormatter.formatDate(notification.createdAt),
                  style: Styles.textStyle12.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (!isRead)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 5, left: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
