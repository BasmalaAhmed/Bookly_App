import 'dart:io';

import 'package:bookly_app/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/features/profile/presentation/manager/profile_cubit/profile_state.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/profile_menu_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  File? _profileImage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const CircularProgressIndicator();
              }
              if (state is ProfileSuccess) {
                return ProfileHeader(
                  name: state.name,
                  email: state.email,
                  image : _profileImage,
                );
              }
              if (state is ProfileFailure) {
                return Text(state.message);
              }

              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 18),
          Divider(color: Colors.white.withValues(alpha: 0.18)),
          const SizedBox(height: 24),
          ProfileMenuSection(onImageUpdated: (image) { 
            setState(() {
              _profileImage = image;
            });
           },),
        ],
      ),
    );
  }
}
