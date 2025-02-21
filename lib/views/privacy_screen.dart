import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/views/widgets/listtile_button.dart';
import 'package:twitter/utils.dart';

class PrivacyScreen extends ConsumerStatefulWidget {
  const PrivacyScreen({super.key});

  @override
  PrivacyScreenState createState() => PrivacyScreenState();
}

class PrivacyScreenState extends ConsumerState<PrivacyScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(ref);
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
          'Privacy',
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
            value: _notifications,
            onChanged: _onNotificationsChanged,
            activeColor: isDark ? Colors.grey.shade700 : Colors.black,
            title: const Text(
              "Private profile",
              style: TextStyle(
                fontSize: Sizes.size18,
              ),
            ),
            secondary: Icon(Icons.lock_outline),
          ),
          ListTileButton(
            leadingIcon: FontAwesomeIcons.threads,
            text: "Mentions",
            trailingIcon: FontAwesomeIcons.chevronRight,
          ),
          ListTileButton(
            leadingIcon: FontAwesomeIcons.bellSlash,
            text: "Muted",
            trailingIcon: FontAwesomeIcons.chevronRight,
          ),
          ListTileButton(
            leadingIcon: FontAwesomeIcons.eyeSlash,
            text: "Hidden Words",
            trailingIcon: FontAwesomeIcons.chevronRight,
          ),
          ListTileButton(
            leadingIcon: Icons.people_outline,
            text: "Profiles you follow",
            trailingIcon: FontAwesomeIcons.chevronRight,
          ),
          Divider(
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListTile(
              title: Text(
                "Other Pricacy settings",
                style: TextStyle(
                  fontSize: Sizes.size18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                "Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.",
                style: TextStyle(
                  fontSize: Sizes.size18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade500,
                ),
              ),
              trailing: FaIcon(
                FontAwesomeIcons.arrowUpRightFromSquare,
                color: Colors.grey.shade400,
                size: Sizes.size20,
              ),
            ),
          ),
          ListTileButton(
            leadingIcon: FontAwesomeIcons.circleXmark,
            text: "Blocked profiles",
            trailingIcon: FontAwesomeIcons.arrowUpRightFromSquare,
          ),
          ListTileButton(
            leadingIcon: Icons.heart_broken_outlined,
            text: "Hide likes",
            trailingIcon: FontAwesomeIcons.arrowUpRightFromSquare,
          ),
        ],
      ),
    );
  }
}
