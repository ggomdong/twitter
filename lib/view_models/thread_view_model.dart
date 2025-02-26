import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/models/thread_model.dart';
import 'package:twitter/repos/threads_repo.dart';

class ThreadViewModel extends StreamNotifier<List<ThreadModel>> {
  late final ThreadsRepository _repository;

  @override
  Stream<List<ThreadModel>> build() {
    _repository = ref.read(threadsRepo);
    return _repository.watchThreads();
  }
}

final threadProvider =
    StreamNotifierProvider<ThreadViewModel, List<ThreadModel>>(
  () => ThreadViewModel(),
);
