import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/features/auth/repository/auth_repo.dart';
import 'package:vritapp/features/auth/sign_in_screen.dart';
import 'package:vritapp/features/base_page/dashboard_screen.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(userAuthProvider).userState.listen((event) {
        if (event != null) {
          if (mounted) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const DashboardScreen(),
            ));
          }
        } else {
          if (mounted) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SignInScreen(),
            ));
          }
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Vrit App",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 150,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
