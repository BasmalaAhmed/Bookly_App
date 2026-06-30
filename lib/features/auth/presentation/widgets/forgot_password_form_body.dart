import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/validators.dart';
import 'package:bookly_app/core/utils/widgets/custom_button.dart';
import 'package:bookly_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:bookly_app/core/utils/widgets/loading_indicator.dart';
import 'package:bookly_app/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/features/auth/manager/auth_cubit/auth_state.dart';
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
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.03,
      ),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password reset link sent to your email')),
            );
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
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
                SizedBox(height: size.height * 0.03),
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
                SizedBox(height: size.height * 0.03),
                CustomRedirectText(
                  text: "Back To",
                  textButton: 'Login',
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kLoginView);
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
