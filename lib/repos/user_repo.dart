import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<void> uploadAvatar(File file, String fileName) async {
    final fileRef = _storage.ref().child("avatars/$fileName");
    await fileRef.putFile(file);
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(data);
  }

  // search_screen 에서 사용하는 메서드. 현재 로그인된 사용자는 제외
  Stream<List<UserProfileModel>> watchUsers(String currentUid) {
    return _db
        .collection("users")
        .where("uid", isNotEqualTo: currentUid)
        .orderBy("uid", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => UserProfileModel.fromJson(doc.data()),
            )
            .toList());
  }
}

final userRepo = Provider(
  (ref) => UserRepository(),
);
