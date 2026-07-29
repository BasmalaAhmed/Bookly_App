import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/helpers.dart';
import 'package:bookly_app/core/utils/validators.dart';
import 'package:bookly_app/core/utils/widgets/custom_button.dart';
import 'package:bookly_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:bookly_app/core/utils/widgets/loading_indicator.dart';
import 'package:bookly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/features/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:bookly_app/core/utils/widgets/custom_redirect_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordFormBody extends StatefulWidget {
  const ForgotPasswordFormBody({super.key});

  @override
  State<ForgotPasswordFormBody> createState() => _ForgotPasswordFormBodyState();
}

class _ForgotPasswordFormBodyState extends State<ForgotPasswordFormBody> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            showCustomDialog(
              context: context,
              title: 'Reset Link Sent',
              message:
                  "We've sent a password reset link to your email.\n\n"
                  "Please check your inbox (and spam folder if needed).",
              buttonTitle: 'Back to Login',
              onPressed: () {
                context.go(AppRouter.kLoginView);
              },
            );
          } else if (state is AuthFailure) {
            showSnackBar(context, state.errMessage);
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  hintText: 'Email',
                  prefixIcon: Icons.mail_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  controller: emailController,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 24),
                CustomButton(
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().resetPassword(
                              email: emailController.text.trim(),
                            );
                          }
                        },
                  child: state is AuthLoading
                      ? const LoadingIndicator()
                      : const Text('Send Reset Link'),
                ),
                const SizedBox(height: 14),
                CustomRedirectText(
                  text: "Back To",
                  textButton: 'Login',
                  onPressed: () {
                    context.go(AppRouter.kLoginView);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
