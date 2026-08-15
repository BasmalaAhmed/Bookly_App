import 'dart:io';

import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/features/profile/presentation/manager/profile_cubit/profile_state.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/edit_profile_bottom_sheet.dart';
import 'package:bookly_app/features/profile/presentation/views/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key, required this.onImageUpdated});

  final void Function(File image) onImageUpdated;

  @override
  Widget build(BuildContext context) {
    const menuItems = [
      (title: 'Edit Profile', icon: FontAwesomeIcons.solidUser, action: 'edit'),
      (
        title: 'Notifications',
        icon: FontAwesomeIcons.solidBell,
        action: 'notifications',
      ),
      (title: 'Settings', icon: FontAwesomeIcons.gear, action: 'settings'),
      (title: 'About', icon: FontAwesomeIcons.circleInfo, action: 'about'),
    ];
    return Column(
      children: [
        ...List.generate(menuItems.length, (index) {
          final item = menuItems[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: ProfileMenuItem(
              title: item.title,
              icon: item.icon,
              onTap: () async {
                switch (item.action) {
                  case 'edit':
                    final state = context.read<ProfileCubit>().state;
                    if (state is! ProfileSuccess) {
                      return;
                    }
                    final profileCubit = context.read<ProfileCubit>();
                    final image = await showModalBottomSheet<File?>(
                      context: context,
                      sheetAnimationStyle: AnimationStyle(
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      ),
                      useRootNavigator: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => BlocProvider.value(
                        value: profileCubit,
                        child: EditProfileBottomSheet(name: state.name),
                      ),
                    );

                    if (image != null) {
                      onImageUpdated(image);
                    }

                    break;

                  case 'notifications':
                    break;

                  case 'settings':
                    context.push(AppRouter.kSettingsView);
                    break;

                  case 'about':
                    break;
                }
              },
            ),
          );
        }),
        ProfileMenuItem(
          title: 'Logout',
          isLogOut: true,
          icon: FontAwesomeIcons.anglesLeft,
          iconColor: Colors.redAccent,
          onTap: () {
            context.read<AuthCubit>().logout();
          },
        ),
      ],
    );
  }
}
