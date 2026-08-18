import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/helpers.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/validators.dart';
import 'package:bookly_app/core/utils/widgets/custom_button.dart';
import 'package:bookly_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:bookly_app/core/utils/widgets/loading_indicator.dart';
import 'package:bookly_app/features/auth/presentation/manager/cubit/change_email_cubit.dart';
import 'package:bookly_app/features/auth/presentation/manager/cubit/change_email_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangeEmailViewBody extends StatefulWidget {
  const ChangeEmailViewBody({super.key});

  @override
  State<ChangeEmailViewBody> createState() => _ChangeEmailViewBodyState();
}

class _ChangeEmailViewBodyState extends State<ChangeEmailViewBody> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _changeEmail() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ChangeEmailCubit>().changeEmail(
      newEmail: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.watch<ChangeEmailCubit>();
    final isLoading = cubit.state is ChangeEmailLoading;
    return BlocListener<ChangeEmailCubit, ChangeEmailState>(
      listener: (context, state) {
        if (state is ChangeEmailFailure) {
          showSnackBar(context, state.errMessage);
        }
        if (state is ChangeEmailSuccess) {
          showCustomDialog(
            context: context,
            title: 'Check Your Email',
            message: 'A verification link has been sent to your new email address. \n\nPlease verify it to complete the email change.',
            buttonTitle: 'Back To Login',
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
              Text('Update your email address', style: Styles.textStyle20),
              const SizedBox(height: 8),
              Text(
                "We'll send a verification link to your new email address.",
                style: Styles.textStyle14.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),

              Text('Current email', style: Styles.textStyle16),
              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorScheme.outline, width: 1.5),
                ),
                child: Text(
                  cubit.currentEmail ?? 'Loading...',
                  style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                hintText: 'Enter your new email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: _emailController,
                validator: Validators.validateEmail,
              ),

              const SizedBox(height: 20),

              CustomTextFormField(
                hintText: 'Enter your password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                textInputAction: TextInputAction.done,
                controller: _passwordController,
                validator: Validators.validatePassword,
              ),

              const SizedBox(height: 32),

              CustomButton(
                onPressed: isLoading ? null : _changeEmail,
                child: isLoading ? const LoadingIndicator() : const Text('Change Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
