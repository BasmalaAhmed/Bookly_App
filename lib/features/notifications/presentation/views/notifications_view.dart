import 'package:bookly_app/features/notifications/presentation/widgets/notifications_view_body.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,),
      body: const SafeArea(child: NotificationsViewBody()),
    );
  }
}
