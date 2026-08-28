import 'package:bookly_app/core/services/notification_service.dart';
import 'package:bookly_app/core/theme/app_theme.dart';
import 'package:bookly_app/core/theme/theme_cubit.dart';
import 'package:bookly_app/core/theme/widgets/app_background.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/service_locator.dart';
import 'package:bookly_app/features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/features/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:bookly_app/features/favorites/data/repos/favorite_repo.dart';
import 'package:bookly_app/features/favorites/presentation/manager/cubit/favorite_cubit.dart';
import 'package:bookly_app/features/notifications/data/repos/notification_repo.dart';
import 'package:bookly_app/features/notifications/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:bookly_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupServiceLocator();
  await getIt<NotificationService>().initialize();
  final themeCubit = ThemeCubit();
  await themeCubit.loadTheme();
  runApp(BooklyApp(themeCubit: themeCubit));
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key, required this.themeCubit});

  final ThemeCubit themeCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthCubit(getIt<AuthRepo>(), getIt<NotificationService>()),
        ),
        BlocProvider(
          create: (context) =>
              FavoriteCubit(getIt<FavoriteRepo>(), getIt<NotificationRepo>()),
        ),
        BlocProvider(
          create: (context) => NotificationCubit(getIt<NotificationRepo>()),
        ),
        BlocProvider.value(value: themeCubit),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if(state is LoginSuccess){
            context.read<NotificationCubit>().watchNotifications();
          }
        },
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              builder: (context, child) {
                return AppBackground(child: child!);
              },
            );
          },
        ),
      ),
    );
  }
}
