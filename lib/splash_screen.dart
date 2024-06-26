import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/common/components/circular_progress_indicator.dart';
import 'package:vritapp/config/config.dart';
import 'package:vritapp/features/auth/repository/auth_repo.dart';
import 'package:vritapp/features/auth/pages/sign_in_screen.dart';
import 'package:vritapp/features/base_page/dashboard_screen.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  StreamSubscription? streamSubscription;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      streamSubscription = ref.read(userAuthProvider).userState.listen((event) {
        if (event != null) {
          if (mounted) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const DashboardScreen(),
            ));
          }
        } else {
          if (mounted) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const SignInScreen(),
            ));
          }
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Vrit App",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.whiteColor, fontSize: 30),
            ),
            const SizedBox(
              height: 150,
            ),
            const CustomLoadedr()
          ],
        ),
      ),
    );
  }
}
