import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/helpers.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/validators.dart';
import 'package:bookly_app/core/utils/widgets/custom_button.dart';
import 'package:bookly_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:bookly_app/core/utils/widgets/loading_indicator.dart';
import 'package:bookly_app/features/settings/presentation/manager/delete_account_cubit/delete_account_cubit.dart';
import 'package:bookly_app/features/settings/presentation/manager/delete_account_cubit/delete_account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DeleteAccountViewBody extends StatefulWidget {
  const DeleteAccountViewBody({super.key});

  @override
  State<DeleteAccountViewBody> createState() => _DeleteAccountViewBodyState();
}

class _DeleteAccountViewBodyState extends State<DeleteAccountViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _deleteAccount() {
    if (!_formKey.currentState!.validate()) return;

    showCustomDialog(
      context: context,
      title: 'Delete Account?',
      message:
          'Your account, profile, favorites, and account data will be permanently deleted. This action cannot be undone.',
      buttonTitle: 'Delete',
      color: Theme.of(context).colorScheme.error,
      icon: FaIcon(FontAwesomeIcons.circleXmark, size: 42, color: Theme.of(context).colorScheme.error,),
      showCancel: true,
      isDelete: true,
      onPressed: () {
        context.read<DeleteAccountCubit>().deleteAccount(
          password: _passwordController.text,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.watch<DeleteAccountCubit>();
    final isLoading = cubit.state is DeleteAccountLoading;
    return BlocListener<DeleteAccountCubit, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountFailure) {
          showSnackBar(context, state.errMessage);
        }
        if (state is DeleteAccountSuccess) {
           context.go(AppRouter.kLoginView);
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('⚠️ This action is permanent', style: Styles.textStyle20.copyWith(color: colorScheme.error, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text(
                "Deleting your account will permanently remove your profile, favorites, and account data. This action cannot be undone. ",
                style: Styles.textStyle14.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),
              Text('Current Password', style: Styles.textStyle16),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: 'Enter your current password',
                prefixIcon: FontAwesomeIcons.lock,
                isPassword: true,
                textInputAction: TextInputAction.done,
                controller: _passwordController,
                validator: Validators.validatePassword,
              ),

              const SizedBox(height: 32),

              CustomButton(
                onPressed: isLoading ? null : _deleteAccount,
                color: colorScheme.error,
                child: isLoading
                    ? const LoadingIndicator()
                    : const Text('Delete Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
