import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/common/widgets/nav_tab.dart';
import 'package:twitter/features/thread/thread_screen.dart';
import 'package:twitter/features/thread/widgets/thread_post.dart';
import 'package:twitter/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onThreadsPostTap() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.size16)),
      ),
      backgroundColor:
          isDarkMode(context) ? Colors.grey.shade900 : Colors.white,
      builder: (context) => ThreadPost(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const ThreadScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(Sizes.size32),
              child: Text("search", style: TextStyle(fontSize: Sizes.size32)),
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(Sizes.size32),
              child:
                  Text("favorites", style: TextStyle(fontSize: Sizes.size32)),
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(Sizes.size32),
              child: Text("profile", style: TextStyle(fontSize: Sizes.size32)),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300,
              width: Sizes.size1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: Sizes.size12,
            right: Sizes.size12,
            top: Sizes.size24,
            bottom: Sizes.size52,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.magnifyingGlass,
                selectedIcon: FontAwesomeIcons.magnifyingGlass,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                isSelected: _selectedIndex == 2,
                icon: FontAwesomeIcons.penToSquare,
                selectedIcon: FontAwesomeIcons.solidPenToSquare,
                onTap: _onThreadsPostTap,
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.heart,
                selectedIcon: FontAwesomeIcons.solidHeart,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(4),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
