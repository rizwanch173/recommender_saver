import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/home/cubit/home_cubit.dart';

import '../../common/firebase_lib.dart';
import '../../constants/colors.dart';

class NoteDetailPage extends StatelessWidget {
  final HomeCubit homeCubit;
  final int index;

  const NoteDetailPage(
      {super.key, required this.homeCubit, required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xff262626), // Background color matching the design
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60.0),
        child: BlocProvider(
          create: (context) => homeCubit,
          child: BlocBuilder<HomeCubit, NoteState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is NoteLoaded)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Button with Glass Effect
                        GlassButton(
                          icon: Icons.arrow_back_ios_new_outlined,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          state.notes[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        // Share Button with Glass Effect
                        GlassButton(
                          icon: Icons.ios_share_outlined,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  if (state is NoteLoaded)
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 100, left: 20, right: 20),
                      child: Column(
                        children: [
                          _NoteDetailWidget(state.notes[index]),
                        ],
                      ),
                    ),
                  SizedBox()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

final String cat_name = "Movie";

class _NoteDetailWidget extends StatelessWidget {
  const _NoteDetailWidget(this.note);
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      decoration: BoxDecoration(
          border: Border.all(
            color:
                secondryColor.withOpacity(0.5), // Purple color for the border
            width: 1, // 1px border width
          ),
          color: Color(0xff262626),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          )),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Name:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                Spacer(),
                Text(
                  "Movie name:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
                color: Colors.purple.withOpacity(0.5),
                width: 1.0,
              ),
            ),
            child: IconButton(
              icon: Icon(icon),
              color: Colors.black, // Icon color
              onPressed: onPressed,
              splashRadius: 25,
            ),
          ),
        ),
      ),
    );
  }
}
