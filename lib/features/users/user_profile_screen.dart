import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/common/main_navigation_screen.dart';
import 'package:twitter/features/users/widgets/custom_button.dart';
import 'package:twitter/features/users/widgets/persistent_tab_bar.dart';
import 'package:twitter/features/users/widgets/reply_sample.dart';
import 'package:twitter/features/users/widgets/thread_sample.dart';
import 'package:twitter/utils.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  final String username, tab;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    context.go("/settings");
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: widget.tab == "replies" ? 1 : 0,
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  leading: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FaIcon(
                      FontAwesomeIcons.globe,
                      size: Sizes.size24,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.instagram,
                        size: Sizes.size28,
                      ),
                    ),
                    IconButton(
                      onPressed: _onGearPressed,
                      icon: const FaIcon(
                        FontAwesomeIcons.bars,
                        size: Sizes.size28,
                      ),
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size16,
                    ),
                    child: Column(
                      children: [
                        Gaps.v10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.username,
                                  style: TextStyle(
                                    fontSize: Sizes.size28,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Gaps.v3,
                                Row(
                                  children: [
                                    Text(
                                      "jane_mobbin",
                                      style: TextStyle(
                                        fontSize: Sizes.size18,
                                      ),
                                    ),
                                    Gaps.h5,
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Sizes.size12,
                                        vertical: Sizes.size5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius:
                                            BorderRadius.circular(Sizes.size40),
                                      ),
                                      child: Text(
                                        "threads.net",
                                        style: TextStyle(
                                          fontSize: Sizes.size12,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Gaps.v10,
                                Text(
                                  "Plant enthusiast!",
                                  style: TextStyle(
                                    fontSize: Sizes.size18,
                                  ),
                                ),
                                Gaps.v10,
                                SizedBox(
                                  height: Sizes.size48,
                                  width: Sizes.size96,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        top: 10,
                                        left: 3,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                "https://i.pravatar.cc/150?img=1",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 6,
                                        left: 15,
                                        child: Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: isDark
                                                  ? Colors.black
                                                  : Colors.white,
                                              width: 4,
                                            ),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                "https://i.pravatar.cc/150?img=2",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 6,
                                        left: 50,
                                        child: Text(
                                          "2 followers",
                                          style: TextStyle(
                                            fontSize: Sizes.size18,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              radius: Sizes.size36,
                              backgroundColor: Colors.grey.shade300,
                              foregroundImage: NetworkImage(
                                  "https://avatars.githubusercontent.com/u/63599714?v=4"),
                            ),
                          ],
                        ),
                        Gaps.v6,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(text: "Edit profile"),
                            CustomButton(text: "Share profile")
                          ],
                        ),
                        Gaps.v20,
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: PersistentTabBar(),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                ListView(
                  children: [
                    ThreadSample(
                      avatarUrl:
                          "https://avatars.githubusercontent.com/u/63599714?v=4",
                      username: "jane_mobbin",
                      text:
                          "Give @john_mobbin a follow if you want to see more travel content!",
                      shareYn: false,
                    ),
                    ThreadSample(
                      avatarUrl:
                          "https://avatars.githubusercontent.com/u/63599714?v=4",
                      username: "jane_mobbin",
                      text: "Tea. Spilliage.",
                      shareYn: true,
                      shareAvatarUrl: "https://i.pravatar.cc/150?img=3",
                      shareUser: "iwetmyyplants",
                      shareText:
                          "I'm just going to say what we are all thinking and knowing is about to go downity down: There is about to be some piping hot tea spillage on here daily that people will be ...",
                      shareImageUrl:
                          "https://picsum.photos/1200/900?random=516",
                    ),
                    ThreadSample(
                      avatarUrl:
                          "https://avatars.githubusercontent.com/u/63599714?v=4",
                      username: "jane_mobbin",
                      text:
                          "I wanna ride a bicycle. But it's too dangerous for me.",
                      shareYn: true,
                      shareAvatarUrl: "https://i.pravatar.cc/150?img=4",
                      shareUser: "bicycle_man",
                      shareText:
                          "Bicycles are parked on the wall. It goes well with the quiet wall. It feels like riding a bicycle along the riverside with warm sunlight. I want to feel it again.",
                      shareImageUrl:
                          "https://picsum.photos/1200/900?random=962",
                    ),
                  ],
                ),
                ListView(
                  children: [
                    ReplySample(
                      avatarUrl: "https://i.pravatar.cc/150?img=5",
                      username: "john_mobbin",
                      elapsedMinutes: 100,
                      text: "Always a dream to see the Medina in Morocco!",
                      shareYn: true,
                      shareAvatarUrl: "https://i.pravatar.cc/150?img=6",
                      shareUser: "earthpix",
                      shareText:
                          "What is one place you're absolutely traveling to by next year?",
                      shareReplies: 256,
                      replyAvatarUrl:
                          "https://avatars.githubusercontent.com/u/63599714?v=4",
                      replyUser: "jane_mobbin",
                      replyElapsedMinutes: 200,
                      replyText: "See you there!",
                    ),
                    ReplySample(
                      avatarUrl: "https://i.pravatar.cc/150?img=6",
                      username: "larena.roob",
                      elapsedMinutes: 255,
                      text:
                          "Dictum non consectetur a erat nam at lectus urna duis.",
                      shareYn: true,
                      shareAvatarUrl: "https://i.pravatar.cc/150?img=7",
                      shareUser: "dariana_hamill",
                      shareText:
                          "Praesent semper feugiat nibh sed pulvinar proin gravida.",
                      shareReplies: 182,
                      replyAvatarUrl:
                          "https://avatars.githubusercontent.com/u/63599714?v=4",
                      replyUser: "jane_mobbin",
                      replyElapsedMinutes: 480,
                      replyText: "What are they saying???????",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
