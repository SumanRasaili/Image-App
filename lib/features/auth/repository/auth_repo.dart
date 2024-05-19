import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/features/base_page/dashboard_screen.dart';

final userAuthProvider = Provider<AuthRepo>((ref) {
  return AuthRepo(firebaseAuth: FirebaseAuth.instance);
});

class AuthRepo {
  final FirebaseAuth firebaseAuth;
  AuthRepo({required this.firebaseAuth});

  Future<void> signInWithGoogle({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credentials =
          GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken);
      var resp =
          await firebaseAuth.signInWithCredential(credentials).then((value) {
        BotToast.closeAllLoading();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ));
        BotToast.showText(text: "Signed In Successfully");
      });
      print("THe signin response is $resp");
    } on FirebaseAuthException catch (e) {
      print("Error $e");
      BotToast.closeAllLoading();
      BotToast.showText(
          backgroundColor: Colors.red, text: e.message.toString());
    }
  }

  Future<User?> getCurrentUserData() async {
    User? userData = firebaseAuth.currentUser;
    return userData;
  }
}
