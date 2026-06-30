import 'package:bookly_app/constants.dart';
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
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.02,
      ),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('User Logged In Successfully')),
            );
            GoRouter.of(context).push(AppRouter.kHomeView);
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
                  textInputAction: TextInputAction.next,
                  controller: emailController,
                  validator: Validators.validateEmail,
                ),
                CustomTextFormField(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outlined,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  controller: passwordController,
                  validator: Validators.validatePassword,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.kForgotPasswordView);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      foregroundColor: kHintTextColor,
                    ),
                    child: Text('Forgot Password?'),
                  ),
                ),
                SizedBox(height: size.height * 0.035),
                CustomButton(
                  onPressed: state is AuthLoading ? null
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
                SizedBox(height: size.height * 0.03),
                CustomRedirectText(
                  text: "Don't have an account?",
                  textButton: 'Register',
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kRegisterView);
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
