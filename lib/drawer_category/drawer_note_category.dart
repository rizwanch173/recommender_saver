import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/category_selection/cubit/category_cubit.dart';
import 'package:recommender_saver/drawer_category/drawer_notes.dart';

import '../../category_selection/models/category_model.dart';
import '../../constants/colors.dart';
import '../home/cubit/home_cubit.dart';

class DrawerNoteCategory extends StatelessWidget {
  const DrawerNoteCategory({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const DrawerNoteCategory());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        // final cubit = BlocProvider.of<CategoryCubit>(context);

        return Expanded(
          child: Column(
            children: [
              if (state is CategoryLoaded)
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200, // Max width for each item
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.9,
                    ), // This removes the default padding
                    scrollDirection: Axis.vertical,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<HomeCubit>(context).toggleNoteSort(
                              isSorted: true,
                              selectedId: state.categories[index].parentId);
                          print(state.categories[index].parentId);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DrawerNotes(
                                      categoryName:
                                          state.categories[index].patent_name,
                                      categoryId:
                                          state.categories[index].parentId,
                                    )),
                          );
                        },
                        child: Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: index % 2 == 0
                                  ? Radius.circular(30)
                                  : Radius.circular(0),
                              topLeft: index % 2 != 0
                                  ? Radius.circular(30)
                                  : Radius.circular(0),
                              bottomRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ),
                            border: Border.all(
                              color: secondryColor.withOpacity(0.5),
                              width: 1,
                            ),
                            color: Color(0xff262626),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft, // 45° angle
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white, // white at the beginning
                                Color(0xFFFBE293), // #fbe293 color
                                Color(0xFFFFC817), // #ffc817 color
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${state.categories[index].patent_name}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      );

                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<HomeCubit>(context).toggleNoteSort(
                              isSorted: true,
                              selectedId: state.categories[index].parentId);
                          print(state.categories[index].parentId);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CategoryButton(
                            category: state.categories[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class CategoryButton extends StatelessWidget {
  final CategoryModel category;

  const CategoryButton({required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, NoteState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state is NoteLoaded)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    color: category.parentId != state.selectedId
                        ? secondryColor.withOpacity(0.5)
                        : secondryColor,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      category.patent_name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    //if (category.count > 0) // Only show count if it's greater than 0
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 8.0),
                    //   child: Container(
                    //     padding: const EdgeInsets.all(6.0),
                    //     decoration: BoxDecoration(
                    //       color: Color(0xff262626),
                    //       shape: BoxShape.circle,
                    //     ),
                    //     child: Text(
                    //       '${0}',
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 12.0,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
