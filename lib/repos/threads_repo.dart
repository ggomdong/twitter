import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/models/thread_model.dart';

class ThreadsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> _uploadPhotoFiles(List<File> photos, String uid) async {
    List<String> fileUrls = [];
    for (var photo in photos) {
      final fileRef = _storage.ref().child(
            "/threads/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}",
          );
      await fileRef.putFile(photo);
      final url = await fileRef.getDownloadURL();
      fileUrls.add(url);
    }
    return fileUrls;
  }

  Future<void> postThread(
      ThreadModel data, List<File> photos, String uid) async {
    List<String> fileUrls = await _uploadPhotoFiles(photos, uid);
    final threadData = data.toJson();

    threadData['fileUrls'] = fileUrls; // 사진 URL을 저장

    await _db.collection("threads").add(threadData);
  }

  // thread_screen 에 표현되는 user 정보를 함께 추출
  Stream<List<ThreadModel>> watchThreads() {
    return _db
        .collection("threads")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .asyncMap(
      (snapshot) async {
        List<ThreadModel> threads = [];

        for (var doc in snapshot.docs) {
          final data = doc.data();
          final creatorUid = data["creatorUid"] ?? "";
          String creator = "";

          if (creatorUid.isNotEmpty) {
            final userDoc = await _db.collection("users").doc(creatorUid).get();
            final userData = userDoc.data();
            if (userDoc.exists &&
                userData != null &&
                userData.containsKey("name")) {
              creator = userData["name"] as String? ?? "anonymous";
            }
          }

          threads.add(ThreadModel.fromJson({
            ...data,
            "creator": creator,
          }));
        }
        return threads;
      },
    );
  }
}

final threadsRepo = Provider((ref) => ThreadsRepository());
