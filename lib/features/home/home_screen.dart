import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/common/components/circular_progress_indicator.dart';
import 'package:vritapp/common/components/custom_text_field.dart';
import 'package:vritapp/config/app_colors.dart';
import 'package:vritapp/core/model/liked_photos_model.dart';
import 'package:vritapp/features/home/provider/liked_state_notifier.dart';
import 'package:vritapp/features/home/provider/photos_provider.dart';
import 'package:vritapp/features/home/search_page.dart';
import 'package:vritapp/features/liked/services/cloud_firestore_services.dart';
import 'package:vritapp/widgets/gridview_content.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homephotos = ref.watch(homeNotifierProvider);
    final homeNotifier = ref.watch(homeNotifierProvider.notifier);
    final likedProv = ref.watch(likedProvider.notifier);
    final photoController = useTextEditingController();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Home"),
        bottom: PreferredSize(
            preferredSize: const Size(200, 60),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CustomTextField(
                labelText: "Photos",
                readOnly: true,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ));
                },
                controller: photoController,
              ),
            )),
      ),
      body: NotificationListener(
        onNotification: homeNotifier.shouldPageNotify,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              if ((homephotos.isLoading) && (homephotos.photos == null)) ...{
                SizedBox(
                    height: MediaQuery.of(context).size.height * .7,
                    child: const Center(
                      child: CustomLoadedr(),
                    ))
              } else if ((!homephotos.isLoading) &&
                  homephotos.photos == null) ...{
                const Center(
                  child: Text("No data"),
                )
              } else if ((!homephotos.isLoading) &&
                  homephotos.photos != null) ...{
                GridView.builder(
                  padding: const EdgeInsets.all(10),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      homephotos.photos != null ? homephotos.photos?.length : 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.7,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return GridViewItem(
                        showLikedButton: true,
                        index: index,
                        photos: homephotos.photos ?? [],
                        isLiked: likedProv.isPhotoLiked(index, homephotos),
                        likedButtonPressed: () async {
                          final likedModel = LikedPhotos(
                              id: "${homephotos.photos?[index].id}",
                              imageUrl:
                                  homephotos.photos?[index].src.portrait ?? "");
                          await ref.read(firebaseFirestoreProvider).addToLiked(
                              ref: ref,
                              likedPhotosModel: likedModel,
                              context: context);
                        });
                  },
                ),
              } else ...{
                const Center(
                  child: Text("Something Went Wrong"),
                )
              },
              const SizedBox(
                height: 10,
              ),
              if (homephotos.isPaginationLoading) ...{
                const Center(
                  child: CustomLoadedr(),
                ),
                const SizedBox(
                  height: 10,
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
