import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/models/user_profile_model.dart';
import 'package:twitter/repos/authentication_repo.dart';
import 'package:twitter/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _userRepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }

    return UserProfileModel.empty();
  }

  // 신규 profile 생성
  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email ?? "anon@anon.com",
      name: credential.user!.displayName ?? "Anon",
      bio: "undefined",
      link: "undefined",
      hasAvatar: false,
      followers: [],
      followerCount: 0,
    );
    await _userRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  // avatar 업로드
  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    await _userRepository.updateUser(state.value!.uid, {"hasAvatar": true});
  }

  // follower update
  Future<void> onFollowerUpdate(String followerUid) async {
    if (_authenticationRepository.isLoggedIn) {
      // follower 대상 정보 조회
      final profile = await _userRepository.findProfile(followerUid);

      if (profile == null) return;

      final user = UserProfileModel.fromJson(profile);

      // follower 업데이트
      List<String> newFollowers = user.followers;
      String loginedUid = _authenticationRepository.user!.uid;

      if (!newFollowers.contains(loginedUid)) {
        newFollowers.add(loginedUid);
      } else {
        newFollowers.remove(loginedUid);
      }

      // follower count 업데이트
      int newFollowerCount = newFollowers.length;

      // DB 업데이트
      Map<String, dynamic> updateData = {
        'followerCount': newFollowerCount,
        'followers': newFollowers,
      };

      await _userRepository.updateUser(
        followerUid,
        updateData,
      );
    }
  }

  // 본인 제외 전체 user 정보 조회
  Stream<List<UserProfileModel>> watchUsers() {
    String currentUid = "";
    if (_authenticationRepository.isLoggedIn) {
      currentUid = _authenticationRepository.user!.uid;
    }
    return _userRepository.watchUsers(currentUid);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
    () => UsersViewModel());
