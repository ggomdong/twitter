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

  Stream<List<ThreadModel>> watchThreads() {
    return _db
        .collection("threads")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => ThreadModel.fromJson(doc.data()),
            )
            .toList());
  }
}

final threadsRepo = Provider((ref) => ThreadsRepository());
