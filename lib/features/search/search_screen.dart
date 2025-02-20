import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/search/user_model.dart';
import 'package:twitter/utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String _searchText = '';

  // 랜덤으로 유저정보 생성
  final List<Users> initialUsers =
      List.generate(20, (index) => Users.generate(index));

  late List<Users> users = initialUsers;

  @override
  void initState() {
    super.initState();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchText = query.toLowerCase();
    });

    if (query.isNotEmpty) {
      users = initialUsers
          .where((user) => user.username.toLowerCase().contains(_searchText))
          .toList();
    } else {
      users = initialUsers;
      _onScaffoldTap();
    }
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _toggleFollow(int index) {
    setState(() {
      users[index].isFollowed = !users[index].isFollowed;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: isDark ? Colors.black : Colors.white,
          toolbarHeight: Sizes.size96 + Sizes.size14,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Search",
                style: TextStyle(
                  fontSize: Sizes.size32,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Gaps.v12,
              CupertinoSearchTextField(
                controller: _textEditingController,
                onChanged: _onSearchChanged,
                padding: EdgeInsets.all(Sizes.size9),
                backgroundColor:
                    isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
                itemColor: Colors.grey,
              ),
            ],
          ),
        ),
        body: ListView.separated(
          itemCount: users.length,
          separatorBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                left: Sizes.size72,
              ),
              child: Divider(
                thickness: 0.5,
                color: Colors.grey.shade500,
              ),
            );
          },
          itemBuilder: (context, index) {
            return ListTile(
              tileColor: isDark ? Colors.black : Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: Sizes.size16,
                vertical: Sizes.size1,
              ),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(users[index].avatarUrl),
                  ),
                  Gaps.v8,
                ],
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        users[index].username,
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.01,
                          height: 1.2,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      Gaps.h5,
                      if (users[index].isFollowed)
                        FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          size: Sizes.size14,
                          color: Colors.blue.shade700,
                        ),
                    ],
                  ),
                  Text(
                    users[index].company,
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
                    "${users[index].followers}K followers",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.01,
                      height: 0.8,
                      color:
                          isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              trailing: Column(
                children: [
                  GestureDetector(
                    onTap: () => _toggleFollow(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size20,
                        vertical: Sizes.size5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: users[index].isFollowed
                              ? Colors.transparent
                              : Colors.grey.shade400,
                        ),
                        color: users[index].isFollowed
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                      child: Text(
                        users[index].isFollowed ? "Following" : "Follow",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.01,
                          color: users[index].isFollowed
                              ? Colors.white
                              : isDark
                                  ? Colors.grey.shade500
                                  : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
