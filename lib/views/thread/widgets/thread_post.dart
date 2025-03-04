import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/view_models/upload_thread_view_model.dart';
import 'package:twitter/view_models/users_view_model.dart';
import 'package:twitter/views/photo/camera_screen.dart';
import 'package:twitter/utils.dart';

class ThreadPost extends ConsumerStatefulWidget {
  const ThreadPost({super.key});

  @override
  ThreadPostState createState() => ThreadPostState();
}

class ThreadPostState extends ConsumerState<ThreadPost> {
  final TextEditingController _textEditingController = TextEditingController();

  String _thread = "";
  final List<File> _selectedPhotos = [];

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      Future.microtask(() {
        setState(() {
          _thread = _textEditingController.text;
        });
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onScaffoldTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void _onBackTap() {
    Navigator.of(context).pop();
  }

  void _onCamera() async {
    final pickedPhoto = await Navigator.of(context).push<XFile?>(
      MaterialPageRoute(
        builder: (context) => CameraScreen(),
      ),
    );

    if (pickedPhoto != null) {
      setState(() {
        _selectedPhotos.add(File(pickedPhoto.path)); // 리스트에 추가
      });
    }
  }

  void _onReplyTap() {
    return;
  }

  void _onPostTap() async {
    if (_thread.isEmpty) return;
    // 로딩 표시
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );

    // 업로드 시작
    await ref
        .read(uploadThreadProvider.notifier)
        .uploadThread(_selectedPhotos, _thread, context);

    // 로딩 대화상자가 이미 닫혔는지 확인
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop(); // 로딩 대화상자 닫기
    }

    // 모달 닫기 (만약 uploadThread 내에서 닫지 않았다면)
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop(); // 모달 닫기
    }
  }

  Widget _buildPhotoPreview() {
    return Wrap(
      children: _selectedPhotos.map(
        (photo) {
          return Container(
            clipBehavior: Clip.hardEdge,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Stack(
              children: [
                Image.file(photo),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _selectedPhotos.remove(photo);
                    }),
                    child: FaIcon(
                      FontAwesomeIcons.solidCircleXmark,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(ref);
    final size = MediaQuery.of(context).size;
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Container(
            height: size.height * 0.93,
            padding: EdgeInsets.symmetric(vertical: Sizes.size14),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(Sizes.size16)),
            ),
            child: GestureDetector(
              onTap: () => _onScaffoldTap(context),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(Sizes.size52),
                  child: AppBar(
                    centerTitle: true,
                    backgroundColor:
                        isDark ? Colors.grey.shade900 : Colors.white,
                    shape: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade400,
                        width: 0.5,
                      ),
                    ),
                    leadingWidth: 100,
                    leading: GestureDetector(
                      onTap: _onBackTap,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size16,
                          vertical: Sizes.size16,
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: Sizes.size18,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      "New thread",
                      style: TextStyle(
                        fontSize: Sizes.size18 + Sizes.size1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size16,
                          vertical: Sizes.size16,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            loadAvatar(data.uid),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Gaps.v10,
                                Container(
                                  width: 2,
                                  height: size.height * 0.06,
                                  color: Colors.grey.shade300,
                                ),
                                Gaps.v10,
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        loadAvatar(data.uid),
                                      ),
                                      fit: BoxFit.cover,
                                      opacity: 0.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gaps.h16,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.name,
                                    style: TextStyle(
                                      fontSize: Sizes.size16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextField(
                                    controller: _textEditingController,
                                    autocorrect: false,
                                    maxLines: null,
                                    textAlignVertical: TextAlignVertical.top,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Start a thread...",
                                      hintStyle: TextStyle(
                                        color: isDark
                                            ? Colors.grey.shade50
                                            : Colors.grey.shade600,
                                        fontSize: Sizes.size16,
                                      ),
                                    ),
                                  ),
                                  Gaps.v5,
                                  _buildPhotoPreview(),
                                  Gaps.v5,
                                  GestureDetector(
                                    onTap: _onCamera,
                                    child: FaIcon(
                                      FontAwesomeIcons.paperclip,
                                      size: Sizes.size20,
                                      color: isDark
                                          ? Colors.grey.shade100
                                          : Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bottomSheet: Container(
                  color: isDark ? Colors.grey.shade900 : Colors.white,
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: Sizes.size16,
                        right: Sizes.size16,
                        bottom: Sizes.size20 +
                            MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Container(
                        width: double.infinity,
                        color: isDark ? Colors.grey.shade900 : Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: _onReplyTap,
                              child: Text(
                                "Anyone can reply",
                                style: TextStyle(
                                  fontSize: Sizes.size16,
                                  color: isDark
                                      ? Colors.white
                                      : Colors.grey.shade500,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: _onPostTap,
                              child: Text(
                                "Post",
                                style: TextStyle(
                                  fontSize: Sizes.size18,
                                  fontWeight: _thread.isNotEmpty
                                      ? FontWeight.w700
                                      : FontWeight.normal,
                                  color: _thread.isNotEmpty
                                      ? Colors.blue.shade200
                                      : Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
