import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/utils.dart';

class ThreadPost extends StatefulWidget {
  const ThreadPost({super.key});

  @override
  State<ThreadPost> createState() => _ThreadPostState();
}

class _ThreadPostState extends State<ThreadPost> {
  final TextEditingController _textEditingController = TextEditingController();

  String _thread = "";

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        _thread = _textEditingController.text;
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

  void _onReplyTap() {
    return;
  }

  void _onPostTap() {
    if (_thread.isEmpty) return;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.93,
      padding: EdgeInsets.symmetric(vertical: Sizes.size14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.size16)),
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
              backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
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
          body: Column(
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
                                    "https://i.pravatar.cc/150",
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
                                "https://i.pravatar.cc/150",
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
                            "ggomdong",
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextField(
                            controller: _textEditingController,
                            autocorrect: false,
                            maxLines: 1,
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
                          FaIcon(
                            FontAwesomeIcons.paperclip,
                            size: Sizes.size20,
                            color: isDark
                                ? Colors.grey.shade100
                                : Colors.grey.shade500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomSheet: Container(
            color: isDark ? Colors.grey.shade900 : Colors.white,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: Sizes.size16,
                  right: Sizes.size16,
                  bottom:
                      Sizes.size20 + MediaQuery.of(context).viewInsets.bottom,
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
                            color: isDark ? Colors.white : Colors.grey.shade500,
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
    );
  }
}
