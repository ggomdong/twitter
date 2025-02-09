import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/activity/activity_model.dart';
import 'package:twitter/utils.dart';

final tabs = [
  "All",
  "Replies",
  "Mentions",
  "Likes",
  "Follows",
];

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: tabs.length,
    vsync: this,
    animationDuration: Duration(
      milliseconds: 200,
    ),
  );

  // 랜덤으로 유저정보 생성
  final List<Activities> initialActivities =
      List.generate(20, (index) => Activities.generate(index))
        ..sort((a, b) => a.elapsedMinutes.compareTo(b.elapsedMinutes));

  late List<Activities> activities = [];

  @override
  void initState() {
    super.initState();
    _onTabChanged(0);
  }

  void _onTabChanged(int index) {
    switch (index) {
      case 0:
        activities = initialActivities;
        break;
      case 1:
        activities = initialActivities
            .where((activity) =>
                activity.categoty == ActivityCategory.reply &&
                !activity.isFollowed)
            .toList();
        break;
      case 2:
        activities = initialActivities
            .where((activity) =>
                activity.categoty == ActivityCategory.mention &&
                !activity.isFollowed)
            .toList();
        break;
      case 3:
        activities = initialActivities
            .where((activity) =>
                activity.categoty == ActivityCategory.like &&
                !activity.isFollowed)
            .toList();
        break;
      case 4:
        activities =
            initialActivities.where((activity) => activity.isFollowed).toList();
        break;
      default:
        activities = initialActivities;
    }
    setState(() {});
  }

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
    final isDark = isDarkMode(context);
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: Sizes.size56,
          backgroundColor: isDark ? Colors.black : Colors.white,
          title: Text(
            "Activity",
            style: TextStyle(
              fontSize: Sizes.size36,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            SizedBox(),
            SizedBox(),
          ],
          bottom: TabBar(
            controller: _tabController,
            onTap: (index) => _onTabChanged(index),
            // 탭바 전체의 패딩
            padding: EdgeInsets.symmetric(horizontal: 10),
            // 탭바 전체적인 정렬
            tabAlignment: TabAlignment.start,
            // splash 효과 유무
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            // 각 탭의 패딩
            labelPadding: EdgeInsets.symmetric(
              horizontal: Sizes.size4,
            ),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16 + Sizes.size1,
              color: isDark ? Colors.black : Colors.white,
            ),
            // indicator란 선택된것에 대한 표현인데, 기본적으로는 indicatorWeight가 있어서 underline이 생김
            // underline을 없애기 위해 indicatorWeight: 0 으로 처리
            // indicatorWeight가 0이면 indicator 속성이 반드시 정의되어야 함
            // 여기서는 탭바의 모양과 동일하게 indicator 모양을 만들기 위해 BoxDecoration 설정
            indicator: BoxDecoration(
              color: isDark ? Colors.white : Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            indicatorWeight: 0,
            unselectedLabelColor: isDark ? Colors.white : Colors.black,
            // 탭바 아래 구분선을 없앰
            dividerColor: Colors.transparent,
            tabs: [
              for (var tab in tabs)
                Container(
                  padding: EdgeInsets.all(1),
                  height: 40,
                  width: Sizes.size96 + Sizes.size16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  child: Tab(
                    text: tab,
                  ),
                ),
            ],
          ),
        ),
        body: ListView.separated(
          itemCount: activities.length,
          separatorBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                left: Sizes.size72,
              ),
              child: Divider(
                thickness: 0.5,
              ),
            );
          },
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: Sizes.size16,
                vertical: 1,
              ),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              activities[index].avatarUrl,
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
                            color: activities[index].isFollowed
                                ? Color(0xFF673FE6)
                                : activities[index].categoty ==
                                        ActivityCategory.mention
                                    ? const Color(0xFF5DC38A)
                                    : activities[index].categoty ==
                                            ActivityCategory.reply
                                        ? Color(0xFF5CC0F9)
                                        : activities[index].categoty ==
                                                ActivityCategory.like
                                            ? Color(0xFFE9337B)
                                            : null,
                            shape: BoxShape.circle,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: FaIcon(
                              activities[index].isFollowed
                                  ? FontAwesomeIcons.solidUser
                                  : activities[index].categoty ==
                                          ActivityCategory.mention
                                      ? FontAwesomeIcons.threads
                                      : activities[index].categoty ==
                                              ActivityCategory.reply
                                          ? FontAwesomeIcons.reply
                                          : activities[index].categoty ==
                                                  ActivityCategory.like
                                              ? FontAwesomeIcons.solidHeart
                                              : null,
                              color: isDark ? Colors.black : Colors.white,
                              size: activities[index].categoty ==
                                      ActivityCategory.mention
                                  ? Sizes.size12
                                  : Sizes.size10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        activities[index].username,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.01,
                          height: 1.2,
                        ),
                      ),
                      Gaps.h5,
                      Text(
                        _convertTime(activities[index].elapsedMinutes),
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    activities[index].isFollowed
                        ? "Followed you"
                        : activities[index].categoty == ActivityCategory.mention
                            ? "Mentioned you"
                            : activities[index].categoty ==
                                    ActivityCategory.reply
                                ? "Replied you"
                                : activities[index].categoty ==
                                        ActivityCategory.like
                                    ? "🎉❤️🔥"
                                    : "error",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.01,
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v10,
                  Text(
                    activities[index].message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.01,
                      height: 0.8,
                    ),
                  ),
                ],
              ),
              trailing: activities[index].isFollowed
                  ? Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size20,
                            vertical: Sizes.size5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          child: Text(
                            "Following",
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.01,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ],
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }
}
