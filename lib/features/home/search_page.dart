import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/common/components/custom_text_field.dart';
import 'package:vritapp/config/app_colors.dart';
import 'package:vritapp/core/model/liked_photos_model.dart';
import 'package:vritapp/features/home/provider/search_provider.dart';
import 'package:vritapp/features/liked/services/cloud_firestore_services.dart';
import 'package:vritapp/widgets/gridview_content.dart';

class SearchPage extends StatefulHookConsumerWidget {
  const SearchPage({super.key});
  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final photoController = useTextEditingController();
    final photoList = ref.watch(searchNotifierProvider);
    final photoNotifier = ref.watch(searchNotifierProvider.notifier);
    final isSearching = useState<bool>(false);
    final timer = useState<Timer?>(null);
    final focusNode = useFocusNode();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Search"),
        bottom: PreferredSize(
            preferredSize: const Size(200, 60),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CustomTextField(
                onFieldSubmitted: (value) async {
                  if (value.isNotEmpty) {
                    ref.read(searchNotifierProvider.notifier).searchPhotos(
                          query: value,
                        );
                  }
                },
                onChanged: (value) {
                  isSearching.value = true;
                  if (timer.value != null) {
                    timer.value?.cancel();
                  }
                  timer.value = Timer(const Duration(seconds: 1), () async {
                    ref.read(searchNotifierProvider.notifier).searchPhotos(
                          query: value,
                        );

                    if (focusNode.hasFocus) {
                      focusNode.unfocus();
                    }
                  });
                  isSearching.value = false;
                },
                labelText: "Photos",
                readOnly: false,
                focusNode: focusNode,
                controller: photoController,
              ),
            )),
      ),
      body: NotificationListener(
        onNotification: photoNotifier.shouldPageNotify,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              if (isSearching.value) ...{
                const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ))
              } else if ((!isSearching.value && photoList.photos == null)) ...{
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      (kTextTabBarHeight +
                          kBottomNavigationBarHeight +
                          kToolbarHeight),
                  child: Center(
                      child: Text(
                    "Nothing to Show",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppColors.whiteColor),
                  )),
                ),
              } else if ((!isSearching.value && photoList.photos != null)) ...{
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount:
                      photoList.photos != null ? photoList.photos!.length : 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.75,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return GridViewItem(
                        showLikedButton: false,
                        photos: photoList.photos ?? [],
                        isLiked: false,
                        likedButtonPressed: () async {
                          final likedModel = LikedPhotos(
                              id: "${photoList.photos?[index].id}",
                              imageUrl:
                                  photoList.photos?[index].src.portrait ?? "");
                          await ref.read(firebaseFirestoreProvider).addToLiked(
                              ref: ref,
                              likedPhotosModel: likedModel,
                              context: context);
                        },
                        index: index);
                  },
                ),
              },
              const SizedBox(
                height: 10,
              ),
              if (photoList.isPaginationLoading) ...{
                const Center(
                  child: CircularProgressIndicator(),
                ),
              },
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
