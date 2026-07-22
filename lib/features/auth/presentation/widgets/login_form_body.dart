import 'package:bookly_app/constants.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/helpers.dart';
import 'package:bookly_app/core/utils/styles.dart';
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

class LoginFormBody extends StatefulWidget {
  const LoginFormBody({super.key});

  @override
  State<LoginFormBody> createState() => _LoginFormBodyState();
}

class _LoginFormBodyState extends State<LoginFormBody> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            showSnackBar(context, 'User Logged In Successfully');
            context.go(AppRouter.kHomeView);
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
                  textInputAction: TextInputAction.next,
                  controller: emailController,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 16,),
                CustomTextFormField(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outlined,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  controller: passwordController,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      context.push(AppRouter.kForgotPasswordView);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: Styles.textStyle14.copyWith(
                        color: kHintTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                CustomButton(
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().loginUser(
                              email: emailController.text.trim(),
                              password: passwordController.text,
                            );
                          }
                        },
                  child: state is AuthLoading
                      ? const LoadingIndicator()
                      : const Text('Login'),
                ),
                const SizedBox(height: 14),
                CustomRedirectText(
                  text: "Don't have an account?",
                  textButton: 'Register',
                  onPressed: () {
                    context.push(AppRouter.kRegisterView);
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
