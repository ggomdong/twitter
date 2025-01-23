import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants/sizes.dart';

class InterestButton extends StatefulWidget {
  const InterestButton({
    super.key,
    required this.interest,
  });

  final String interest;

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        width: size.width / 2 - 40,
        height: Sizes.size80 + Sizes.size2,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _isSelected ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(
            Sizes.size10,
          ),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.2),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: Sizes.size5,
              left: Sizes.size10,
              child: Text(
                widget.interest,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.bold,
                    color: _isSelected ? Colors.white : Colors.black87),
              ),
            ),
            Positioned(
              top: Sizes.size10,
              right: Sizes.size10,
              child: FaIcon(
                FontAwesomeIcons.solidCircleCheck,
                size: Sizes.size18,
                color: _isSelected ? Colors.white : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
