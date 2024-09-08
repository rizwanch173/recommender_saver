import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/category_selection/cubit/category_cubit.dart';
import 'package:recommender_saver/constants/colors.dart';
import 'package:recommender_saver/home/view/note_category.dart';

import '../../add_note/view/add_note_page.dart';
import '../../common/category_selection_widget.dart';
import '../../common/glass_back_button.dart';
import '../../common/glass_floating_action_button.dart';
import '../../home/home.dart';
import '../../home/view/note_detail.dart';

class CategorySelection extends StatelessWidget {
  const CategorySelection({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const CategorySelection());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 60.0),
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            final cubit = BlocProvider.of<CategoryCubit>(context);

            return Column(
              children: [
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
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Please select the category to create note",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                if (state is CategoryLoaded)
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                          top: 20), // Removes any default padding
                      scrollDirection: Axis.vertical,
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddNotePage(
                                    category: state.categories[index],
                                  ),
                                ),
                              );
                            },
                            child: CategorySelectionWidget(
                              category: state.categories[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: GlassFloatingActionButton(
        icon: Icons.add,
        onPressed: () {},
      ),
    );
  }
}
