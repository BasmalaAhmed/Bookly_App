import 'package:bookly_app/features/settings/presentation/widgets/delete_account_view_body.dart';
import 'package:flutter/material.dart';

class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete Account'), backgroundColor: Colors.transparent,),
      body: const SafeArea(child: DeleteAccountViewBody()),
    );
  }
}