import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/helpers.dart';
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

class RegisterFormBody extends StatefulWidget {
  const RegisterFormBody({super.key});

  @override
  State<RegisterFormBody> createState() => _RegisterFormBodyState();
}

class _RegisterFormBodyState extends State<RegisterFormBody> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal:12,
        vertical: 16,
      ),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            showSnackBar(context, 'User Created Successfully');
            context.go(AppRouter.kHomeView);
          }
          else if (state is AuthFailure) {
            showSnackBar(context, state.errMessage);
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  hintText: 'Username',
                  prefixIcon: Icons.person_2_outlined,
                  textInputAction: TextInputAction.next,
                  controller: usernameController,
                  validator: Validators.validateUsername,
                ),
                const SizedBox(height: 16,),
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
                  textInputAction: TextInputAction.next,
                  controller: passwordController,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 16,),
                CustomTextFormField(
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock_outlined,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  controller: confirmPasswordController,
                  validator: (value) {
                    return Validators.validateConfirmPassword(
                      value,
                      passwordController.text,
                    );
                  },
                ),
                const SizedBox(height: 45,),
                CustomButton(
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().registerUser(
                              email: emailController.text.trim(),
                              password: passwordController.text,
                            );
                          }
                        },
                  child: state is AuthLoading
                      ? const LoadingIndicator()
                      : const Text('Register'),
                ),
                const SizedBox(height: 14),
                CustomRedirectText(
                  text: 'Already have an account?',
                  textButton: 'Login',
                  onPressed: () {
                    context.push(AppRouter.kLoginView);
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
