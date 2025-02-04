import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/threads/threads_classes.dart';
import 'package:twitter/utils.dart';

class ThreadsScreen extends StatefulWidget {
  const ThreadsScreen({super.key});

  @override
  State<ThreadsScreen> createState() => _ThreadsScreenState();
}

class _ThreadsScreenState extends State<ThreadsScreen> {
  // 최신 Post가 상단에 오도록 하기 위해, faker 패키지로 랜덤 생성한 posts를 elapsedTime으로 정렬
  final List<Post> posts = List.generate(10, (index) => Post.generate())
    ..sort((a, b) => a.elapsedMinutes.compareTo(b.elapsedMinutes));

  // elapsedMinutes에 따라 표기방법(분, 시간, 일)을 다르게 해주는 함수
  String _convertTime(int minutes) {
    switch (minutes) {
      case <= 60:
        return "${minutes}m";
      case <= 1440:
        return "${(minutes / 60).floor()}h";
      default:
        return "${(minutes / 1440).floor()}d";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: FaIcon(
              FontAwesomeIcons.threads,
              size: Sizes.size40,
            ),
            centerTitle: true,
            floating: true,
            snap: true,
            expandedHeight: 80,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final post = posts[index];
                return Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              // CircleAvatar(
                              //   backgroundImage: NetworkImage(post.avatarUrl),
                              //   onBackgroundImageError:
                              //       (exception, stackTrace) {
                              //     debugPrint("Image load failed: $exception");
                              //   },
                              // ),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          post.avatarUrl,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // Inner circle (with a plus icon)
                                  Positioned(
                                    top: 22,
                                    left: 22,
                                    child: Container(
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2.5,
                                        ),
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: FaIcon(
                                          FontAwesomeIcons.plus,
                                          color: Colors.white,
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
                                height: post.imageUrls.isNotEmpty
                                    ? Sizes.size96 + Sizes.size96 + Sizes.size72
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          post.username,
                                          style: TextStyle(
                                            fontSize: Sizes.size16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Gaps.h10,
                                        if (post.subscribed)
                                          FaIcon(
                                            FontAwesomeIcons.solidCircleCheck,
                                            size: Sizes.size12,
                                            color: Colors.blue.shade700,
                                          ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _convertTime(post.elapsedMinutes),
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
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  post.content,
                                  // 이미지가 있으면 1줄, 없으면 2줄
                                  maxLines: post.imageUrls.isNotEmpty ? 1 : 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: Sizes.size16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (post.imageUrls.isNotEmpty)
                                  Column(
                                    children: [
                                      Gaps.v10,
                                      SizedBox(
                                        height: Sizes.size96 +
                                            Sizes.size96 +
                                            Sizes.size20, // 이미지 높이 지정
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: post.imageUrls.length,
                                          itemBuilder: (context, imgIndex) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  right: Sizes.size10),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Sizes.size8),
                                                child: Image.network(
                                                    post.imageUrls[imgIndex]),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                Gaps.v16,
                                Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.heart),
                                    Gaps.h20,
                                    FaIcon(FontAwesomeIcons.comment),
                                    Gaps.h20,
                                    FaIcon(FontAwesomeIcons.arrowsRotate),
                                    Gaps.h20,
                                    FaIcon(FontAwesomeIcons.paperPlane),
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
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: post.replies == 0
                                ? null
                                : post.replies == 1
                                    ? Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            top: 5,
                                            left: 5,
                                            child: CircleAvatar(
                                              radius: 15,
                                              backgroundImage: NetworkImage(
                                                post.repliesAvatars[0],
                                              ),
                                              onBackgroundImageError:
                                                  (exception, stackTrace) {
                                                debugPrint(
                                                    "Image load failed: $exception");
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : post.replies == 2
                                        ? Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              // 왼쪽 반원 아바타
                                              Positioned(
                                                top: 10,
                                                left: 3,
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.red,
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        post.repliesAvatars[0],
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment
                                                        .centerLeft, // 왼쪽 반만 보이도록 설정
                                                  ),
                                                ),
                                              ),
                                              Gaps.h10,
                                              // 오른쪽 전체 원형 아바타
                                              Positioned(
                                                top: 6,
                                                left: 15,
                                                child: Container(
                                                  width: 28,
                                                  height: 28,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 4,
                                                    ),
                                                    shape: BoxShape.circle,
                                                    color: Colors.blue,
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        post.repliesAvatars[1],
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                top: 10,
                                                left: 0,
                                                child: CircleAvatar(
                                                  radius: 9,
                                                  backgroundImage: NetworkImage(
                                                    post.repliesAvatars[0],
                                                  ),
                                                  onBackgroundImageError:
                                                      (exception, stackTrace) {
                                                    debugPrint(
                                                        "Image load failed: $exception");
                                                  },
                                                ),
                                              ),
                                              Positioned(
                                                top: 28,
                                                left: 17,
                                                child: CircleAvatar(
                                                  radius: 7,
                                                  backgroundImage: NetworkImage(
                                                    post.repliesAvatars[1],
                                                  ),
                                                  onBackgroundImageError:
                                                      (exception, stackTrace) {
                                                    debugPrint(
                                                        "Image load failed: $exception");
                                                  },
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                left: 21,
                                                child: CircleAvatar(
                                                  radius: 11,
                                                  backgroundImage: NetworkImage(
                                                    post.repliesAvatars[2],
                                                  ),
                                                  onBackgroundImageError:
                                                      (exception, stackTrace) {
                                                    debugPrint(
                                                        "Image load failed: $exception");
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                          ),
                          Gaps.h10,
                          Expanded(
                            child: Column(children: [
                              DefaultTextStyle(
                                style: TextStyle(
                                  fontSize: Sizes.size16 + Sizes.size1,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade500,
                                ),
                                child: Row(
                                  children: [
                                    Text("${post.replies} replies"),
                                    Gaps.h5,
                                    Text("·"),
                                    Gaps.h5,
                                    Text("${post.likes} likes"),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v20,
                    Container(
                      height: 1.5,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                    ),
                    Gaps.v20,
                  ],
                );
              },
              childCount: posts.length,
            ),
          ),
        ],
      ),
    );
  }
}





                          // ListTile(
                          //   leading: Container(
                          //     height: double.infinity,
                          //     decoration: BoxDecoration(
                          //       color: Colors.red,
                          //     ),
                          //     child: Column(
                          //       children: [
                          //         CircleAvatar(
                          //           backgroundImage: NetworkImage(post.avatarUrl),
                          //           onBackgroundImageError: (exception, stackTrace) {
                          //             debugPrint("Image load failed: $exception");
                          //           },
                          //           // 에러발생시 기본 아이콘 표시
                          //           child: Icon(
                          //             Icons.person,
                          //             size: Sizes.size32,
                          //           ),
                          //         ),
                          //         Gaps.v10,
                          //         Expanded(
                          //           child: Container(
                          //             width: 2,
                          //             height: 100,
                          //             color: Colors.grey.shade300,
                          //             margin: EdgeInsets.only(top: Sizes.size4),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          //   title: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Row(
                          //         children: [
                          //           Text(
                          //             post.username,
                          //             style: TextStyle(
                          //               fontSize: Sizes.size14,
                          //               fontWeight: FontWeight.w800,
                          //             ),
                          //           ),
                          //           Gaps.h10,
                          //           if (post.subscribed)
                          //             FaIcon(
                          //               FontAwesomeIcons.solidCircleCheck,
                          //               size: Sizes.size12,
                          //               color: Colors.blue.shade700,
                          //             ),
                          //         ],
                          //       ),
                          //       Row(
                          //         children: [
                          //           Text(
                          //             _convertTime(post.elapsedMinutes),
                          //             style: TextStyle(
                          //               color: Colors.grey.shade500,
                          //             ),
                          //           ),
                          //           Gaps.h14,
                          //           Text(
                          //             "···",
                          //             style: TextStyle(
                          //               fontSize: Sizes.size24,
                          //               fontWeight: FontWeight.w800,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          //   subtitle: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         post.content,
                          //         // 이미지가 있으면 1줄, 없으면 2줄
                          //         maxLines: post.imageUrls.isNotEmpty ? 1 : 2,
                          //         overflow: TextOverflow.ellipsis,
                          //         style: TextStyle(
                          //           fontSize: Sizes.size16,
                          //           fontWeight: FontWeight.w500,
                          //         ),
                          //       ),
                          //       if (post.imageUrls.isNotEmpty)
                          //         Column(
                          //           children: [
                          //             Gaps.v10,
                          //             SizedBox(
                          //               height:
                          //                   Sizes.size96 + Sizes.size96, // 이미지 높이 지정
                          //               child: ListView.builder(
                          //                 scrollDirection: Axis.horizontal,
                          //                 itemCount: post.imageUrls.length,
                          //                 itemBuilder: (context, imgIndex) {
                          //                   return Padding(
                          //                     padding:
                          //                         EdgeInsets.only(right: Sizes.size8),
                          //                     child: ClipRRect(
                          //                       borderRadius: BorderRadius.circular(
                          //                           Sizes.size8),
                          //                       // child: Image.network(
                          //                       //     post.imageUrls[imgIndex]),
                          //                     ),
                          //                   );
                          //                 },
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       Gaps.v16,
                          //       Row(
                          //         children: [
                          //           FaIcon(FontAwesomeIcons.heart),
                          //           Gaps.h20,
                          //           FaIcon(FontAwesomeIcons.comment),
                          //           Gaps.h20,
                          //           FaIcon(FontAwesomeIcons.arrowsRotate),
                          //           Gaps.h20,
                          //           FaIcon(FontAwesomeIcons.paperPlane),
                          //         ],
                          //       ),
                          //       Gaps.v20,
                          //       DefaultTextStyle(
                          //         style: TextStyle(
                          //           fontSize: Sizes.size16,
                          //           fontWeight: FontWeight.w500,
                          //           color: Colors.grey.shade500,
                          //         ),
                          //         child: Row(
                          //           children: [
                          //             Text("${post.replies} replies"),
                          //             Gaps.h5,
                          //             Text("·"),
                          //             Gaps.h5,
                          //             Text("${post.likes} likes"),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Gaps.v20,
                          // Container(
                          //   height: 1.5,
                          //   width: double.infinity,
                          //   color: Colors.grey.shade200,
                          // ),