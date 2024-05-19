import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/features/home/provider/home_provider.dart';
import 'package:vritapp/features/home/search_page.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homephotos = ref.watch(homeNotifierProvider);
    final photoController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Home Screen"),
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
        bottom: PreferredSize(
            preferredSize: const Size(200, 60),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                readOnly: true,
                controller: photoController,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ));
                },
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: "Search Photos",
                    border: OutlineInputBorder()),
              ),
            )),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        if ((homephotos.isLoading == true) && (homephotos.photos == null)) ...{
          const SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(),
              ))
        } else if ((homephotos.isLoading == false) &&
            homephotos.photos == null) ...{
          const Center(
            child: Text("No data"),
          )
        } else if ((homephotos.isLoading == false) &&
            homephotos.photos != null) ...{
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                homephotos.photos!.isNotEmpty ? homephotos.photos!.length : 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 0,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Image.network(
                                homephotos.photos?[index].src.large ?? ""),
                          );
                        },
                      );
                    },
                    child: CachedNetworkImage(
                        imageUrl:
                            homephotos.photos?[index].src.portrait ?? "")),
              );
            },
          )
        } else ...{
          const Center(
            child: Text("Something Went Wrong"),
          )
        }
      ])),
    );
  }
}
