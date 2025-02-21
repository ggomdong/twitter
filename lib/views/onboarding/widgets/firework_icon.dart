import 'package:flutter/material.dart';

class FireworkIcon extends StatefulWidget {
  const FireworkIcon({super.key});

  @override
  State<FireworkIcon> createState() => _FireworkIconState();
}

class _FireworkIconState extends State<FireworkIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + _controller.value * 0.5,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.celebration,
                color: Colors.pink,
                size: 16,
              ),
            ],
          ),
        );
      },
    );
  }
}
