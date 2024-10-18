import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:recommender_saver/constants/colors.dart';

class GlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  GlassButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(20.0), // Rounded corners for the glass effect
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 10.0, sigmaY: 10.0), // Blur effect for frosted glass
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color:
                  Colors.white.withOpacity(0.2), // Semi-transparent background
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: secondryColor.withOpacity(0.5),
                width: 1.0,
              ),
            ),
            child: Center(
              child: IconButton(
                icon: Icon(icon),
                color: Colors.white.withOpacity(0.6), // Icon color
                onPressed: onPressed,
                splashRadius: 25,
                splashColor: secondryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
