import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/utils.dart';

class ThreadPost extends StatelessWidget {
  const ThreadPost({super.key});

  void _onBackTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.93,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: isDark ? Colors.grey.shade500 : Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.size64),
          child: AppBar(
            centerTitle: true,
            shape: Border(
              bottom: BorderSide(
                color: Colors.grey.shade400,
                width: 0.5,
              ),
            ),
            leadingWidth: 100,
            leading: GestureDetector(
              onTap: () => _onBackTap(context),
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
                fontSize: Sizes.size20,
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
                          Positioned(
                            top: 22,
                            left: 22,
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isDark ? Colors.black : Colors.white,
                                  width: 2.5,
                                ),
                                color: isDark ? Colors.white : Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: FaIcon(
                                  FontAwesomeIcons.plus,
                                  color: isDark ? Colors.black : Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.v10,
                      Container(
                        width: 2,
                        height: size.height * 0.2,
                        color: Colors.grey.shade300,
                      ),
                      Gaps.v10,
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
                  Gaps.h16,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                          maxLines: 2,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Start a thread",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: Sizes.size18,
                            ),
                          ),
                        ),
                        FaIcon(
                          FontAwesomeIcons.paperclip,
                          size: Sizes.size20,
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
    );
  }
}
