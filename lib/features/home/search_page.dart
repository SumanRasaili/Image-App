import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/features/home/provider/search_provider.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoController = useTextEditingController();
    final photoList = ref.watch(searchNotifierProvider);
    final isSearching = useState<bool>(false);
    final timer = useState<Timer?>(null);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Search"),
          bottom: PreferredSize(
              preferredSize: const Size(200, 60),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  onTap: () {},
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      isSearching.value = true;
                      if (timer.value != null) {
                        timer.value?.cancel();
                      }
                      timer.value = Timer(const Duration(seconds: 1), () async {
                        ref
                            .read(searchNotifierProvider.notifier)
                            .searchPhotos(query: value);
                        isSearching.value = false;
                      });
                    }
                  },
                  controller: photoController,
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      suffixIcon: photoController.text.isNotEmpty
                          ? const Icon(Icons.close)
                          : const Icon(Icons.search),
                      hintText: "Search Photos",
                      border: const OutlineInputBorder()),
                ),
              )),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          if (isSearching.value && (photoList.photos == null)) ...{
            const SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ))
          } else if (!isSearching.value && photoList.photos == null) ...{
            const SizedBox(
              height: 200,
              child: Center(child: Text("Nothing to Show")),
            ),
          } else
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:
                  photoList.photos != null ? photoList.photos!.length : 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                // childAspectRatio: 0.9,
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 20,
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
                                child: InteractiveViewer(
                                  child: Image.network(
                                      photoList.photos?[index].src.large ?? ""),
                                ),
                              );
                            },
                          );
                        },
                        child: CachedNetworkImage(
                            imageUrl:
                                photoList.photos?[index].src.portrait ?? "")));
              },
            )
        ])));
  }
}
