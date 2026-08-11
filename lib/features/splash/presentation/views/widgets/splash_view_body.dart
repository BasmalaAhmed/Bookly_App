import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/assets.dart';
import 'package:bookly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/features/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:bookly_app/features/splash/presentation/views/widgets/sliding_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  AuthState? _authState;
  bool _splashFinished = false;

  @override
  void initState() {
    super.initState();
    _startSlidingAnimation();
    _startSplash();
    context.read<AuthCubit>().checkAuthStatus();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess || state is AuthInitial) {
          _authState = state;
          _tryNavigate();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(AssetsData.logo),
          const SizedBox(height: 4),
          SlidingText(slidingAnimation: slidingAnimation),
        ],
      ),
    );
  }

  void _startSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 4),
      end: Offset.zero,
    ).animate(animationController);
    animationController.forward();
  }

  Future<void> _startSplash() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    _splashFinished = true;
    _tryNavigate();
  }

  void _tryNavigate() {
    if (!_splashFinished || _authState == null || !mounted) {
      return;
    }

    if (_authState is LoginSuccess) {
      context.go(AppRouter.kHomeView);
    } else if (_authState is AuthInitial) {
      context.go(AppRouter.kLoginView);
    }
  }
}
