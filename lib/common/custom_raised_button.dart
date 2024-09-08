import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomRaisedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomRaisedButton({
    Key? key,
    required this.text,
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
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
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
                  color: secondryColor.withOpacity(0.5),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 15,
                    ),
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

class GlassEffectButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color secondaryColor;

  const GlassEffectButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glass border effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 40, // Adjusted width for a smaller button
              height: 40, // Adjusted height for a smaller button
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 2, // Reduced border width for a smaller button
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(2, 2), // Shadow position
                  ),
                ],
              ),
            ),
          ),
          // Actual button with a secondary color background
          Positioned(
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                width: 32, // Adjusted width for button inside the border
                height: 32, // Adjusted height for button inside the border
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: secondaryColor.withOpacity(0.5),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 10, // Adjusted font size for smaller button
                    ),
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
