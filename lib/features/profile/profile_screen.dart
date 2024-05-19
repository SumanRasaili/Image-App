import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vritapp/features/auth/provider/user_data_notifier.dart';
import 'package:vritapp/features/auth/repository/auth_repo.dart';
import 'package:vritapp/textformfield_widget.dart';

class ProfileScreen extends StatefulHookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final ImagePicker picker = ImagePicker();
  File? image;

  setImage({required File image}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userPickedImage', image.path);
  }

  Future<String> getImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userPickedImage')!;
  }

  @override
  Widget build(BuildContext context) {
    final userProfData = ref.watch(userDataProvider);
    final dateController = useTextEditingController();

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
                                await ref
                                    .read(userAuthProvider)
                                    .signOutUser()
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
                height: 10,
              ),
              Stack(
                children: [
                  image == null
                      ? CachedNetworkImage(
                          imageUrl: userProfData?.photoURL ?? "",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 150.0,
                            height: 200.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : CachedNetworkImage(
                          imageUrl: userProfData?.photoURL ?? "",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 150.0,
                            height: 200.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: FileImage(image!), fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                  // SizedBox(
                  //     width: 150.0, height: 200.0, child: Image.file(image!)),
                  Positioned(
                      bottom: 30,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: IconButton(
                            onPressed: () async {
                              XFile? file = await picker.pickImage(
                                  source: ImageSource.camera);
                              if (file != null) {
                                setState(() {
                                  image = File(file.path);
                                  setImage(image: File(image?.path ?? ""));
                                });
                              }
                            },
                            iconSize: 20,
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      ))
                ],
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
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Container(
                    decoration: const BoxDecoration(),
                    child: CustomTextField(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 7)));

                          if (pickedDate != null) {
                            var today = DateTime.now().day;
                            var month = DateTime.now().month;
                            var year = DateTime.now().year;
                            if (pickedDate.year == year &&
                                pickedDate.month == month &&
                                pickedDate.day == today) {
                              print("Happy Birthday");
                            } else {
                              print("Sad Birthday");
                            }

                            dateController.text =
                                DateFormat("yyyy-MM-dd").format(pickedDate);
                          }
                          print("Picked date is $pickedDate");
                        },
                        controller: dateController,
                        labeltext: "Pick date")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
