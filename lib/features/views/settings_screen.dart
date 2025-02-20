import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/common/main_navigation_screen.dart';
import 'package:twitter/features/view_models/config_vm.dart';
import 'package:twitter/features/views/widgets/listtile_button.dart';
import 'package:twitter/utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _onPrivacyPressed() {
    context.go("/settings/privacy");
  }

  void _onShowModal() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Are you sure?"),
        content: const Text("Please don't go"),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No"),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            isDestructiveAction: true,
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                context.go("/profile"); // pop이 불가능하면 profile로 이동
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  size: Sizes.size18,
                  color: isDark ? Colors.white : Colors.black,
                ),
                Gaps.h5,
                Text(
                  "Back",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        leadingWidth: 100,
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: Sizes.size20,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.symmetric(
              horizontal: Sizes.size20,
            ),
            value: context.watch<ConfigViewModel>().darkmode,
            onChanged: (value) =>
                context.read<ConfigViewModel>().setDarkmode(value),
            title: Text(
              "Dark Mode",
              style: TextStyle(
                fontSize: Sizes.size18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            secondary: Icon(
              isDark ? Icons.dark_mode_outlined : Icons.sunny,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          ListTileButton(
            leadingIcon: Icons.person_add_outlined,
            text: "Follow and invite friends",
          ),
          ListTileButton(
            leadingIcon: FontAwesomeIcons.bell,
            text: "Notifications",
          ),
          ListTileButton(
            leadingIcon: Icons.lock_outline,
            text: "Privacy",
            onPressed: _onPrivacyPressed,
          ),
          ListTileButton(
            leadingIcon: FontAwesomeIcons.circleUser,
            text: "Account",
          ),
          ListTileButton(
            leadingIcon: FontAwesomeIcons.lifeRing,
            text: "Help",
          ),
          AboutListTile(
            icon: FaIcon(
              Icons.info_outline,
              size: Sizes.size32,
              color: isDark ? Colors.white : Colors.black,
            ),
            applicationName: "",
            applicationVersion: "1.0",
            applicationLegalese: "Don't copy me.",
            child: Text(
              'About',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
              ), // ListTile의 기본 텍스트 색 변경
            ),
          ),
          Divider(
            thickness: 0.5,
          ),
          ListTile(
            title: const Text(
              "Log out",
              style: TextStyle(
                fontSize: Sizes.size18,
              ),
            ),
            textColor: Colors.blue,
            onTap: _onShowModal,
          ),
        ],
      ),
    );
  }
}
