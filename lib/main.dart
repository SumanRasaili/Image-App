import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:vritapp/core/model/local_isar_photos_model.dart';
import 'package:vritapp/core/notification_service/notification_services.dart';
import 'package:vritapp/firebase_options.dart';
import 'package:vritapp/splash_screen.dart';

// late Isar isar;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Notificationservice().initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final dir = await getApplicationDocumentsDirectory();
  // isar = await Isar.open(
  //   [PhotosCollectionSchema],
  //   directory: dir.path,
  // );
  runApp(ProviderScope(child: Phoenix(child: const MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'Flutter Demo',
        builder: BotToastInit(),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
