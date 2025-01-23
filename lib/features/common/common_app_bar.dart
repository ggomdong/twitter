import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/utils.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.type,
    this.isSignup,
  });

  final LeadingType type;
  final bool? isSignup;

  void _onBackTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: FaIcon(
        FontAwesomeIcons.twitter,
        size: Sizes.size32,
        color: Theme.of(context).primaryColor,
      ),
      leadingWidth: type == LeadingType.cancel ? 100 : 40,
      leading: type == LeadingType.none
          ? null
          : type == LeadingType.arrow
              ? GestureDetector(
                  onTap: () => _onBackTap(context),
                  child: Icon(Icons.arrow_back),
                )
              : GestureDetector(
                  onTap: () => _onBackTap(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size16,
                      vertical: Sizes.size16,
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ),
                ),
    );
  }
}
