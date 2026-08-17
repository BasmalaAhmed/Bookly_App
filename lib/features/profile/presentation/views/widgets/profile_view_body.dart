import 'dart:io';

import 'package:bookly_app/core/theme/widgets/app_background.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/helpers.dart';
import 'package:bookly_app/core/utils/widgets/loading_indicator.dart';
import 'package:bookly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/features/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:bookly_app/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/features/profile/presentation/manager/profile_cubit/profile_state.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/profile_menu_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  File? _profileImage;
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            context.go(AppRouter.kLoginView);
          }
          if (state is AuthFailure) {
            showSnackBar(context, state.errMessage);
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
          child: Column(
            children: [
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    if (state.name != null && state.email != null) {
                      return ProfileHeader(
                        name: state.name!,
                        email: state.email!,
                        image: _profileImage,
                      );
                    }
                    return const LoadingIndicator();
                  }
                  if (state is ProfileSuccess) {
                    return ProfileHeader(
                      name: state.name,
                      email: state.email,
                      image: _profileImage,
                    );
                  }
                  if (state is ProfileFailure) {
                    return Text(state.message);
                  }
      
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 18),
              Divider(),
              const SizedBox(height: 24),
              ProfileMenuSection(
                onImageUpdated: (image) {
                  setState(() {
                    _profileImage = image;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
