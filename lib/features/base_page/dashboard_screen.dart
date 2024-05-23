import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/features/home/pages/home_screen.dart';
import 'package:vritapp/features/home/pages/liked_image_pages.dart';
import 'package:vritapp/features/profile/profile_screen.dart';

class DashboardScreen extends HookConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState<int>(0);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        if (selectedIndex.value != 0) {
          selectedIndex.value = selectedIndex.value - 1;
          return;
        }
        showDialog(
          context: context,
          builder: (ctx) {
            return Dialog(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Exit?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Are you sure want to exit?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ButtonBar(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: const Text("No"),
                      ),
                      FilledButton(
                        onPressed: () {
                          exit(0);
                        },
                        child: const Text("YES"),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          
            currentIndex: selectedIndex.value,
            onTap: (value) {
              selectedIndex.value = value;
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Liked"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ]),
        body: switch (selectedIndex.value) {
          0 => const HomeScreen(),
          1 => const LikedImagesScreen(),
          2 => const ProfileScreen(),
          _ => const SizedBox(),
        },
      ),
    );
  }
}
