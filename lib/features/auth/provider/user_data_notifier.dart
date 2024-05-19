import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vritapp/features/auth/repository/auth_repo.dart';

final userDataProvider = StateNotifierProvider<UserDataNotifier, User?>((ref) {
  return UserDataNotifier(ref: ref);
});

class UserDataNotifier extends StateNotifier<User?> {
  UserDataNotifier({required this.ref}) : super(null) {
    getUserData();
  }

  Ref ref;

  getUserData() async {
    final respData = await ref.read(userAuthProvider).getCurrentUserData();
    state = respData;
  }
}
