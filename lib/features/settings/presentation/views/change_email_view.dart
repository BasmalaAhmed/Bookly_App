import 'package:bookly_app/features/settings/presentation/widgets/change_email_view_body.dart';
import 'package:flutter/material.dart';

class ChangeEmailView extends StatelessWidget {
  const ChangeEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Email'), backgroundColor: Colors.transparent,),
      body: const SafeArea(child: ChangeEmailViewBody()),
    );
  }
}
