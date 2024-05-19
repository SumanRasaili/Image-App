import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/features/auth/provider/user_data_notifier.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfData = ref.watch(userDataProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Profile Screen"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                          content: const Text("Do you really want to LogOut?"),
                          actions: [
                            FilledButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                              child: const Text("No"),
                            ),
                            FilledButton(
                              onPressed: () async {
                                await FirebaseAuth.instance
                                    .signOut()
                                    .then((value) => Phoenix.rebirth(ctx));
                              },
                              child: const Text("YES"),
                            ),
                          ],
                          title: const Text("Log Out"));
                    });
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              CachedNetworkImage(
                  height: 100,
                  width: 200,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(image: imageProvider)),
                    );
                  },
                  imageUrl: userProfData?.photoURL ?? ""),
              const SizedBox(
                height: 15,
              ),
              Text(
                userProfData?.displayName ?? "",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                userProfData?.email ?? "",
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
