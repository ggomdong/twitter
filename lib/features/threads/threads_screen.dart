import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/utils.dart';

class ThreadsScreen extends StatefulWidget {
  const ThreadsScreen({super.key});

  @override
  State<ThreadsScreen> createState() => _ThreadsScreenState();
}

class _ThreadsScreenState extends State<ThreadsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    // return Scaffold(
    //   backgroundColor: isDark ? null : Colors.grey.shade50,
    //   appBar: AppBar(
    //     backgroundColor: isDark ? null : Colors.grey.shade50,
    //     centerTitle: true,
    //     automaticallyImplyLeading: false,
    //     title: FaIcon(
    //       FontAwesomeIcons.threads,
    //       size: Sizes.size40,
    //     ),
    //   ),
    //   body: Scrollbar(
    //     controller: _scrollController,
    //     child: ListView.separated(
    //       controller: _scrollController,
    //       padding: const EdgeInsets.only(
    //         top: Sizes.size10,
    //         bottom: Sizes.size96 + Sizes.size20,
    //         left: Sizes.size16,
    //         right: Sizes.size16,
    //       ),
    //       separatorBuilder: (context, index) {
    //         return Column(
    //           children: [
    //             Gaps.v10,
    //             Container(
    //               height: 1,
    //               width: double.infinity,
    //               color: Colors.grey.shade200,
    //             ),
    //             Gaps.v10,
    //           ],
    //         );
    //       },
    //       itemCount: 10,
    //       itemBuilder: (context, index) => Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           CircleAvatar(
    //             radius: 18,
    //             backgroundColor: isDark ? Colors.grey.shade500 : null,
    //             child: const Text("꼼동"),
    //           ),
    //           Gaps.h10,
    //           Expanded(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   '꼼동',
    //                   style: TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: Sizes.size14,
    //                       color: Colors.grey.shade500),
    //                 ),
    //                 Gaps.v3,
    //                 const Text(
    //                     "That's not it l've seen the same thing but also in a cave,")
    //               ],
    //             ),
    //           ),
    //           Gaps.h10,
    //           Column(
    //             children: [
    //               FaIcon(
    //                 FontAwesomeIcons.heart,
    //                 size: Sizes.size20,
    //                 color: Colors.grey.shade500,
    //               ),
    //               Gaps.v2,
    //               Text(
    //                 '52.2K',
    //                 style: TextStyle(
    //                   color: Colors.grey.shade500,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          title: FaIcon(
            FontAwesomeIcons.threads,
            size: Sizes.size40,
          ),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.only(
                top: Sizes.size10,
                bottom: Sizes.size96 + Sizes.size20,
                left: Sizes.size16,
                right: Sizes.size16,
              ),
              separatorBuilder: (context, index) {
                return Column(
                  children: [
                    Gaps.v10,
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                    ),
                    Gaps.v10,
                  ],
                );
              },
              itemCount: 10,
              itemBuilder: (context, index) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: isDark ? Colors.grey.shade500 : null,
                    child: const Text("꼼동"),
                  ),
                  Gaps.h10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '꼼동',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Sizes.size14,
                              color: Colors.grey.shade500),
                        ),
                        Gaps.v3,
                        const Text(
                            "That's not it l've seen the same thing but also in a cave,")
                      ],
                    ),
                  ),
                  Gaps.h10,
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.heart,
                        size: Sizes.size20,
                        color: Colors.grey.shade500,
                      ),
                      Gaps.v2,
                      Text(
                        '52.2K',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          itemExtent: 100,
        )
      ],
    );
  }
}
