import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/helpers.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/validators.dart';
import 'package:bookly_app/core/utils/widgets/custom_button.dart';
import 'package:bookly_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:bookly_app/core/utils/widgets/loading_indicator.dart';
import 'package:bookly_app/features/settings/presentation/manager/change_password_cubit/change_password_cubit.dart';
import 'package:bookly_app/features/settings/presentation/manager/change_password_cubit/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordViewBody extends StatefulWidget {
  const ChangePasswordViewBody({super.key});

  @override
  State<ChangePasswordViewBody> createState() => _ChangePasswordViewBodyState();
}

class _ChangePasswordViewBodyState extends State<ChangePasswordViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ChangePasswordCubit>().changePassword(
      currentPassword: _currentPasswordController.text,
      newPassword: _newPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.watch<ChangePasswordCubit>();
    final isLoading = cubit.state is ChangePasswordLoading;
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordFailure) {
          showSnackBar(context, state.errMessage);
        }
        if (state is ChangePasswordSuccess) {
          showCustomDialog(
            context: context,
            title: 'Password Updated',
            message: 'Your Password has been updated. \n\nPlease Log In Again.',
            buttonTitle: 'Login Again',
            onPressed: () => context.go(AppRouter.kLoginView),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Update your password', style: Styles.textStyle20),
              const SizedBox(height: 8),
              Text(
                "Enter your current password and choose a new one.",
                style: Styles.textStyle14.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),
              CustomTextFormField(
                hintText: 'Enter your current password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                textInputAction: TextInputAction.next,
                controller: _currentPasswordController,
                validator: Validators.validatePassword,
              ),

              const SizedBox(height: 20),

              CustomTextFormField(
                hintText: 'New Password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                textInputAction: TextInputAction.next,
                controller: _newPasswordController,
                validator: Validators.validatePassword,
              ),

              const SizedBox(height: 20),

              CustomTextFormField(
                hintText: 'Confirm New Password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                textInputAction: TextInputAction.done,
                controller: _confirmNewPasswordController,
                validator: (value) {
                  return Validators.validateConfirmPassword(
                    value,
                    _newPasswordController.text,
                  );
                },
              ),

              const SizedBox(height: 32),

              CustomButton(
                onPressed: isLoading ? null : _changePassword,
                child: isLoading ? const LoadingIndicator() : const Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
