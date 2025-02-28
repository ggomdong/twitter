import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/view_models/thread_view_model.dart';
import 'package:twitter/views/thread/widgets/thread_modal.dart';
import 'package:twitter/utils.dart';

class ThreadScreen extends ConsumerStatefulWidget {
  static const routeURL = "/home";
  static const routeName = "home";
  const ThreadScreen({super.key});

  @override
  ThreadScreenState createState() => ThreadScreenState();
}

class ThreadScreenState extends ConsumerState<ThreadScreen> {
  void _onThreadsModalTap() async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.size16)),
      ),
      backgroundColor: isDarkMode(ref) ? Colors.grey.shade900 : Colors.white,
      builder: (context) => ThreadModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(ref);
    final threadState = ref.watch(threadProvider);

    return Scaffold(
      body: threadState.when(
        loading: () => Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) => Center(child: Text("Error: $error")),
        data: (threads) {
          if (threads.isEmpty) {
            return Center(child: Text("No threads available"));
          }
          return CustomScrollView(
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
                    final thread = threads[index];

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size16),
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
                                          // color: Colors.blue,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                loadAvatar(thread.creatorUid)),
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
                                              color: isDark
                                                  ? Colors.black
                                                  : Colors.white,
                                              width: 2.5,
                                            ),
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: FaIcon(
                                              FontAwesomeIcons.plus,
                                              color: isDark
                                                  ? Colors.black
                                                  : Colors.white,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gaps.v10,
                                  // Container(
                                  //   width: 2,
                                  //   height: thread.fileUrls.isNotEmpty
                                  //       ? Sizes.size96 +
                                  //           Sizes.size96 +
                                  //           Sizes.size72
                                  //       : Sizes.size64,
                                  //   color: Colors.grey.shade300,
                                  // ),
                                ],
                              ),
                              Gaps.h10,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              thread.creator,
                                              style: TextStyle(
                                                fontSize: Sizes.size16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Gaps.h10,
                                            if (true)
                                              FaIcon(
                                                FontAwesomeIcons
                                                    .solidCircleCheck,
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
                                              calculateTimeByCreatedAt(
                                                  thread.createdAt),
                                              style: TextStyle(
                                                fontSize: Sizes.size16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                            Gaps.h14,
                                            GestureDetector(
                                              onTap: _onThreadsModalTap,
                                              child: Text(
                                                "···",
                                                style: TextStyle(
                                                  fontSize: Sizes.size16,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(
                                      thread.thread,
                                      // 이미지가 있으면 1줄, 없으면 2줄
                                      maxLines:
                                          thread.fileUrls.isNotEmpty ? 1 : 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: Sizes.size16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    if (thread.fileUrls.isNotEmpty)
                                      Column(
                                        children: [
                                          Gaps.v10,
                                          SizedBox(
                                            height: Sizes.size96 +
                                                Sizes.size96 +
                                                Sizes.size20, // 이미지 높이 지정
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: thread.fileUrls.length,
                                              itemBuilder: (context, imgIndex) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      right: Sizes.size10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Sizes.size8),
                                                    child: Image.network(thread
                                                        .fileUrls[imgIndex]),
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
                                        Gaps.h10,
                                        Text("${thread.likes}"),
                                        Gaps.h20,
                                        FaIcon(FontAwesomeIcons.comment),
                                        Gaps.h10,
                                        Text("${thread.replies}"),
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
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: Sizes.size16,
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       SizedBox(
                        //         width: 40,
                        //         height: 40,
                        //         child: thread.replies == 0
                        //             ? null
                        //             : thread.replies == 1
                        //                 ? Stack(
                        //                     clipBehavior: Clip.none,
                        //                     children: [
                        //                       Positioned(
                        //                         top: 5,
                        //                         left: 5,
                        //                         child: CircleAvatar(
                        //                           radius: 15,
                        //                           foregroundColor: Colors.green,
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   )
                        //                 : thread.replies == 2
                        //                     ? Stack(
                        //                         clipBehavior: Clip.none,
                        //                         children: [
                        //                           Positioned(
                        //                             top: 10,
                        //                             left: 3,
                        //                             child: Container(
                        //                               width: 20,
                        //                               height: 20,
                        //                               decoration: BoxDecoration(
                        //                                 shape: BoxShape.circle,
                        //                                 color: Colors.green,
                        //                                 // image: DecorationImage(
                        //                                 //   image: NetworkImage(
                        //                                 //     post.repliesAvatars[
                        //                                 //         0],
                        //                                 //   ),
                        //                                 //   fit: BoxFit.cover,
                        //                                 // ),
                        //                               ),
                        //                             ),
                        //                           ),
                        //                           Positioned(
                        //                             top: 6,
                        //                             left: 15,
                        //                             child: Container(
                        //                               width: 28,
                        //                               height: 28,
                        //                               decoration: BoxDecoration(
                        //                                 border: Border.all(
                        //                                   color: isDark
                        //                                       ? Colors.black
                        //                                       : Colors.white,
                        //                                   width: 4,
                        //                                 ),
                        //                                 shape: BoxShape.circle,
                        //                                 color: Colors.red,
                        //                                 // image: DecorationImage(
                        //                                 //   image: NetworkImage(
                        //                                 //     post.repliesAvatars[
                        //                                 //         1],
                        //                                 //   ),
                        //                                 //   fit: BoxFit.cover,
                        //                                 // ),
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         ],
                        //                       )
                        //                     : Stack(
                        //                         clipBehavior: Clip.none,
                        //                         children: [
                        //                           Positioned(
                        //                             top: 10,
                        //                             left: 0,
                        //                             child: CircleAvatar(
                        //                               radius: 9,
                        //                               // backgroundImage:
                        //                               //     NetworkImage(
                        //                               //   post.repliesAvatars[0],
                        //                               // ),
                        //                               // onBackgroundImageError:
                        //                               //     (exception,
                        //                               //         stackTrace) {
                        //                               //   debugPrint(
                        //                               //       "Image load failed: $exception");
                        //                               // },
                        //                             ),
                        //                           ),
                        //                           Positioned(
                        //                             top: 28,
                        //                             left: 17,
                        //                             child: CircleAvatar(
                        //                               radius: 7,
                        //                               // backgroundImage:
                        //                               //     NetworkImage(
                        //                               //   post.repliesAvatars[1],
                        //                               // ),
                        //                               // onBackgroundImageError:
                        //                               //     (exception,
                        //                               //         stackTrace) {
                        //                               //   debugPrint(
                        //                               //       "Image load failed: $exception");
                        //                               // },
                        //                             ),
                        //                           ),
                        //                           Positioned(
                        //                             top: 0,
                        //                             left: 21,
                        //                             child: CircleAvatar(
                        //                               radius: 11,
                        //                               // backgroundImage:
                        //                               //     NetworkImage(
                        //                               //   post.repliesAvatars[2],
                        //                               // ),
                        //                               // onBackgroundImageError:
                        //                               //     (exception,
                        //                               //         stackTrace) {
                        //                               //   debugPrint(
                        //                               //       "Image load failed: $exception");
                        //                               // },
                        //                             ),
                        //                           ),
                        //                         ],
                        //                       ),
                        //       ),
                        //       Gaps.h10,
                        //       // Expanded(
                        //       //   child: Column(children: [
                        //       //     DefaultTextStyle(
                        //       //       style: TextStyle(
                        //       //         fontSize: Sizes.size16 + Sizes.size1,
                        //       //         fontWeight: FontWeight.w400,
                        //       //         color: const Color.fromARGB(255, 8, 6, 6),
                        //       //       ),
                        //       //       child: Row(
                        //       //         children: [
                        //       //           Text("${thread.replies} replies"),
                        //       //           Gaps.h5,
                        //       //           Text("·"),
                        //       //           Gaps.h5,
                        //       //           Text("${thread.likes} likes"),
                        //       //         ],
                        //       //       ),
                        //       //     ),
                        //       //   ]),
                        //       // ),
                        //     ],
                        //   ),
                        // ),
                        Gaps.v20,
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey.shade200,
                        ),
                        Gaps.v20,
                      ],
                    );
                  },
                  childCount: threads.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
