import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/common/glass_back_button.dart';
import 'package:recommender_saver/constants/colors.dart';
import 'package:recommender_saver/drawer_category/drawer_note_category.dart';
import 'package:recommender_saver/home/cubit/home_cubit.dart';

class DrawerCategoryPage extends StatelessWidget {
  const DrawerCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 60.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button with Glass Effect
                GlassButton(
                  icon: Icons.arrow_back_ios_new_outlined,
                  onPressed: () {
                    BlocProvider.of<HomeCubit>(context)
                        .toggleNoteSort(isSorted: false, selectedId: '');
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                SizedBox(
                  width: 40,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            const DrawerNoteCategory(),
          ],
        ),
      ),
    );
  }
}
