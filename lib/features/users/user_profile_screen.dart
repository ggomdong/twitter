import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/settings/settings_screen.dart';
import 'package:twitter/features/users/widgets/persistent_tab_bar.dart';
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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
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
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size40,
                                vertical: Sizes.size5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              child: Text(
                                "Edit profile",
                                style: TextStyle(
                                  fontSize: Sizes.size18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.01,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size40,
                                vertical: Sizes.size5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              child: Text(
                                "Share profile",
                                style: TextStyle(
                                  fontSize: Sizes.size18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.01,
                                ),
                              ),
                            )
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
                Column(
                  children: [
                    ThreadSample(),
                    ThreadSample(),
                    ThreadSample(),
                  ],
                ),
                const Center(
                  child: Text('Page two'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
