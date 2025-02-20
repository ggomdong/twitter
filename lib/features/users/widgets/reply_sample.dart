import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/thread/widgets/thread_modal.dart';
import 'package:twitter/utils.dart';

class ReplySample extends StatelessWidget {
  const ReplySample({
    super.key,
    required this.avatarUrl,
    required this.username,
    required this.elapsedMinutes,
    required this.text,
    required this.shareYn,
    this.shareAvatarUrl,
    this.shareUser,
    this.shareText,
    this.shareReplies,
    required this.replyAvatarUrl,
    required this.replyUser,
    required this.replyElapsedMinutes,
    required this.replyText,
  });

  final String avatarUrl;
  final String username;
  final int elapsedMinutes;
  final String text;
  final bool shareYn;
  final String? shareAvatarUrl;
  final String? shareUser;
  final String? shareText;
  final int? shareReplies;
  final String replyAvatarUrl;
  final String replyUser;
  final int replyElapsedMinutes;
  final String replyText;

  void _onThreadsModalTap(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.size16)),
      ),
      backgroundColor:
          isDarkMode(context) ? Colors.grey.shade900 : Colors.white,
      builder: (context) => ThreadModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: Sizes.size16,
            right: Sizes.size16,
            top: Sizes.size16,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          avatarUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Gaps.v10,
                  Container(
                    width: 2,
                    height: shareYn
                        ? Sizes.size96 + Sizes.size96 + Sizes.size32
                        : Sizes.size64,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
              Gaps.h10,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              username,
                              style: TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            Gaps.h10,
                            FaIcon(
                              FontAwesomeIcons.solidCircleCheck,
                              size: Sizes.size12,
                              color: Colors.blue.shade700,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              convertTime(elapsedMinutes),
                              style: TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Gaps.h14,
                            GestureDetector(
                              onTap: () => _onThreadsModalTap(context),
                              child: Text(
                                "···",
                                style: TextStyle(
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.w900,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    if (shareYn)
                      Column(
                        children: [
                          Gaps.v10,
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 10,
                                      foregroundImage: NetworkImage(
                                        shareAvatarUrl!,
                                      ),
                                    ),
                                    Gaps.h10,
                                    Text(
                                      shareUser!,
                                      style: TextStyle(
                                        fontSize: Sizes.size16,
                                        fontWeight: FontWeight.w600,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    Gaps.h5,
                                    FaIcon(
                                      FontAwesomeIcons.solidCircleCheck,
                                      size: Sizes.size14,
                                      color: Colors.blue.shade700,
                                    ),
                                  ],
                                ),
                                Gaps.v10,
                                Text(
                                  shareText!,
                                  style: TextStyle(
                                    fontSize: Sizes.size16,
                                    fontWeight: FontWeight.w500,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                                Gaps.v24,
                                Text(
                                  "$shareReplies replies",
                                  style: TextStyle(
                                    fontSize: Sizes.size16 + Sizes.size1,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    Gaps.v16,
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.heart,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        Gaps.h20,
                        FaIcon(
                          FontAwesomeIcons.comment,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        Gaps.h20,
                        FaIcon(
                          FontAwesomeIcons.arrowsRotate,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        Gaps.h20,
                        FaIcon(
                          FontAwesomeIcons.paperPlane,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ],
                    ),
                    Gaps.v16,
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size16,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade300,
                foregroundImage: NetworkImage(
                  replyAvatarUrl,
                ),
              ),
              Gaps.h10,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          replyUser,
                          style: TextStyle(
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              convertTime(replyElapsedMinutes),
                              style: TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Gaps.h14,
                            Text(
                              "···",
                              style: TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w900,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      replyText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Sizes.size16 + Sizes.size1,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Gaps.v16,
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.heart,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        Gaps.h20,
                        FaIcon(
                          FontAwesomeIcons.comment,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        Gaps.h20,
                        FaIcon(
                          FontAwesomeIcons.arrowsRotate,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        Gaps.h20,
                        FaIcon(
                          FontAwesomeIcons.paperPlane,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Gaps.v20,
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey.shade200,
        ),
      ],
    );
  }
}
