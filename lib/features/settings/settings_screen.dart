import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/features/common/main_navigation_screen.dart';
import 'package:twitter/features/settings/widgets/listtile_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _onPrivacyPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainNavigationScreen(index: 6),
      ),
    );
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
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.chevronLeft, size: Sizes.size18),
                Gaps.h5,
                Text(
                  "Back",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                  ),
                ),
              ],
            ),
          ),
        ),
        leadingWidth: 100,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: Sizes.size20,
            fontWeight: FontWeight.w700,
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
          const AboutListTile(
            icon: FaIcon(
              Icons.info_outline,
              size: Sizes.size32,
            ),
            applicationName: "",
            applicationVersion: "1.0",
            applicationLegalese: "Don't copy me.",
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
