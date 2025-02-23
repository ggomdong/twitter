import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/repos/authentication_repo.dart';
import 'package:twitter/view_models/settings_vm.dart';
import 'package:twitter/views/users/widgets/listtile_button.dart';
import 'package:twitter/utils.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _onPrivacyPressed(BuildContext context) {
    context.go("/settings/privacy");
  }

  void _onShowModal(BuildContext context, WidgetRef ref) {
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
            onPressed: () {
              ref.read(authRepo).signOut();
              context.go("/");
            },
            isDestructiveAction: true,
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = isDarkMode(ref);
    return Scaffold(
      appBar: AppBar(
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
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.symmetric(
              horizontal: Sizes.size20,
            ),
            value: ref.watch(settingsProvider).darkMode,
            onChanged: (value) =>
                ref.read(settingsProvider.notifier).setDarkMode(value),
            title: const Text(
              "Dark Mode",
              style: TextStyle(
                fontSize: Sizes.size18,
              ),
            ),
            secondary: Icon(
                isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
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
            onPressed: () => _onPrivacyPressed(context),
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
            onTap: () => _onShowModal(context, ref),
          ),
        ],
      ),
    );
  }
}
