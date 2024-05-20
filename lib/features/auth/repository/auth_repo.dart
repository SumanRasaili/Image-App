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

  Future<void> signOutUser() async {
    await firebaseAuth.signOut();
  }

  Stream<User?> get userState => firebaseAuth.authStateChanges();

  Future<void> signInWithGoogle({required BuildContext context}) async {
    try {
      BotToast.showLoading();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credentials =
          GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken);
      await firebaseAuth.signInWithCredential(credentials).then((value) {
        BotToast.closeAllLoading();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ));
        BotToast.showText(text: "Signed In Successfully");
      });
    } on FirebaseAuthException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(
          backgroundColor: Colors.red, text: e.message.toString());
    }
  }

  Future<User?> getCurrentUserData() async {
    User? userData;
    try {
      userData = firebaseAuth.currentUser;
      return userData;
    } on FirebaseAuthException catch (e) {
      debugPrint("The user data error is ${e.toString()}");
    }
    return userData;
  }
}
