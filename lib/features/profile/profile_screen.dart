import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vritapp/core/notification_service/notification_services.dart';
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
  late SharedPreferences prefs;

  setImage({required File image}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userPickedImage', image.path);
  }

  getImage() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getString('userPickedImage') != null) {
      setState(() {
        image = File(prefs.getString('userPickedImage')!);
      });
    } else {
      setState(() {
        image = null;
      });
    }
  }

  @override
  void initState() {
    getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProfData = ref.watch(userDataProvider);
    final dateController = useTextEditingController();
    print("image url is ${image == null}");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Profile"),
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
                              border: Border.all(color: Colors.grey),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : Container(
                          width: 150.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                            image: DecorationImage(
                                image: FileImage(image!), fit: BoxFit.cover),
                          ),
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
                                // image = File(await getImage() ?? "");
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Select your date of birth to see magic",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 5,
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
                              Notificationservice().showNotificationdetail();
                            } else {
                              BotToast.showText(
                                  text: "Mystery remain unsolved");
                            }

                            dateController.text =
                                DateFormat("yyyy-MM-dd").format(pickedDate);
                          }
                        },
                        controller: dateController,
                        labeltext: "Date of Birth")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
