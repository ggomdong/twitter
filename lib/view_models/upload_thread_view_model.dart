import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/models/thread_model.dart';
import 'package:twitter/repos/authentication_repo.dart';
import 'package:twitter/repos/threads_repo.dart';

class UploadThreadViewModel extends AsyncNotifier<void> {
  late final ThreadsRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(threadsRepo);
  }

  Future<void> uploadThread(
      List<File> photos, String thread, BuildContext context) async {
    final user = ref.read(authRepo).user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.postThread(
        ThreadModel(
          thread: thread,
          fileUrls: [],
          creatorUid: user!.uid,
          likes: 0,
          replies: 0,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          creator: user.displayName ?? "anonymous",
        ),
        photos,
        user.uid,
      );
      // 모달을 닫고 홈으로 이동
      Navigator.of(context).pop();
      // 필요시 홈 화면 새로고침을 위해 이벤트를 발생시키거나 추가 작업 수행
    });
  }
}

final uploadThreadProvider = AsyncNotifierProvider<UploadThreadViewModel, void>(
  () => UploadThreadViewModel(),
);
