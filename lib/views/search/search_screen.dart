import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/models/user_profile_model.dart';
import 'package:twitter/utils.dart';
import 'package:twitter/view_models/users_view_model.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String _searchText = '';
  List<UserProfileModel> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchText = query.toLowerCase();
    });
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _toggleFollow(String followerUid) {
    setState(() {
      ref.read(usersProvider.notifier).onFollowerUpdate(followerUid);
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(ref);
    final loginUser = ref.watch(usersProvider);
    final userStream = ref.watch(usersProvider.notifier).watchUsers();

    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
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
              ),
            ],
          ),
        ),
        body: StreamBuilder<List<UserProfileModel>>(
          stream: userStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No users found."));
            }

            _filteredUsers = snapshot.data!
                .where((user) => user.name.toLowerCase().contains(_searchText))
                .toList();
            return ListView.separated(
              itemCount: _filteredUsers.length,
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(left: Sizes.size72),
                  child: Divider(thickness: 0.5),
                );
              },
              itemBuilder: (context, index) {
                final user = _filteredUsers[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Sizes.size16,
                    vertical: Sizes.size1,
                  ),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(loadAvatar(user.uid)),
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
                            user.name,
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.01,
                              height: 1.2,
                            ),
                          ),
                          Gaps.h5,
                          if (user.followers.contains(loginUser.value!.uid))
                            FaIcon(
                              FontAwesomeIcons.solidCircleCheck,
                              size: Sizes.size14,
                              color: Colors.blue.shade700,
                            ),
                        ],
                      ),
                      Text(
                        user.bio,
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
                        "${user.followerCount} followers",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.01,
                          height: 0.8,
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _toggleFollow(user.uid),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size20,
                            vertical: Sizes.size5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: user.followers.contains(loginUser
                                      .value!.uid) // users[index].isFollowed
                                  ? Colors.transparent
                                  : Colors.grey.shade400,
                            ),
                            color: user.followers.contains(loginUser
                                    .value!.uid) // users[index].isFollowed
                                ? Theme.of(context).primaryColor
                                : null,
                          ),
                          child: Text(
                            user.followers.contains(loginUser
                                    .value!.uid) // users[index].isFollowed
                                ? "Following"
                                : "Follow",
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.01,
                              color: user.followers.contains(loginUser
                                      .value!.uid) // users[index].isFollowed
                                  ? Colors.white
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
