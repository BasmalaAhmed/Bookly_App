import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/widgets/loading_indicator.dart';
import 'package:bookly_app/features/notifications/presentation/manager/notification_settings_cubit/notification_settings_cubit.dart';
import 'package:bookly_app/features/notifications/presentation/manager/notification_settings_cubit/notification_settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class NotificationBottomSheet extends StatelessWidget {
  const NotificationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.75,
        minHeight: MediaQuery.sizeOf(context).height * 0.15,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: Theme.of(
          context,
        ).colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
      ),
      child: LiquidGlassLayer(
        child: LiquidGlass(
          shape: LiquidRoundedRectangle(borderRadius: 30),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              18,
              24,
              32 + MediaQuery.viewInsetsOf(context).bottom,
            ),
            child:
                BlocBuilder<
                  NotificationSettingsCubit,
                  NotificationSettingsState
                >(
                  builder: (context, state) {
                    if (state is NotificationSettingLoading) {
                      return const Center(child: LoadingIndicator());
                    }

                    if (state is NotificationSettingSuccess) {
                      return Row(
                        children: [
                          Text(
                            'Turn on notifications',
                            style: Styles.textStyle18,
                          ),
                          const Spacer(),
                          Switch(
                            value: state.isEnabled,
                            onChanged: (value) {
                              context
                                  .read<NotificationSettingsCubit>()
                                  .setNotificationsEnabled(value);
                            },
                          ),
                        ],
                      );
                    }
                    if (state is NotificationSettingFailure) {
                      return Center(child: Text(state.errMessage));
                    }
                    return const SizedBox.shrink();
                  },
                ),
          ),
        ),
      ),
    );
  }
}
