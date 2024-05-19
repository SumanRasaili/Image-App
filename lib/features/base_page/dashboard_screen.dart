import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/features/home/home_screen.dart';
import 'package:vritapp/features/liked/liked_image_pages.dart';
import 'package:vritapp/features/profile/profile_screen.dart';

class DashboardScreen extends HookConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState<int>(0);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex.value,
          onTap: (value) {
            selectedIndex.value = value;
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Liked"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
      body: switch (selectedIndex.value) {
        0 => const HomeScreen(),
        1 => const LikedImagesScreen(),
        2 => const ProfileScreen(),
        _ => const SizedBox(),
      },
    );
  }
}