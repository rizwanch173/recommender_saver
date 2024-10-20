import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/colors.dart';

class GlassFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const GlassFloatingActionButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // This creates the glass border effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: secondryColor.withOpacity(0.3),
                  width: 4,
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          // This is the actual button with black background
          Positioned(
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
