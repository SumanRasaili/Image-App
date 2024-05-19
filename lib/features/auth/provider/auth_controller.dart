import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/features/auth/repository/auth_repo.dart';

final authProvider = Provider<AuthController>((ref) {
  return AuthController(ref: ref);
});

class AuthController {
  AuthController({required this.ref});
  Ref ref;
  signInWithGoogle(BuildContext context) {
    ref.read(userAuthProvider).signInWithGoogle(
          context: context,
        );
  }
}
