import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_base_kit/app/assets/color_manager.dart';
import 'package:flutter_base_kit/app/assets/constants.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initializeSplashScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: GradientColorManager.backgroundGradient,
        ),
        child: const Center(
          child: Text(
            'DUM DUM',
            style: TextStyle(
              fontSize: 32,
            ),
          ),
        ),
      ),
    );
  }
}

extension _Init on _SplashScreenPageState {
  Future<void> initializeSplashScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      context.go(NavigatePath.homeScreen1);
    }
  }
}
