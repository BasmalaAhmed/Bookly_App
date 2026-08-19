import 'package:bookly_app/features/settings/presentation/widgets/change_password_view_body.dart';
import 'package:flutter/material.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password'), backgroundColor: Colors.transparent,),
      body: const SafeArea(child: ChangePasswordViewBody()),
    );
  }
}