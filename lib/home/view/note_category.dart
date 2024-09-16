import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/category_selection/cubit/category_cubit.dart';

import '../../category_selection/models/category_model.dart';
import '../../constants/colors.dart';
import '../cubit/home_cubit.dart';

class NoteCategory extends StatelessWidget {
  const NoteCategory({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const NoteCategory());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<CategoryCubit>(context);
        //  cubit.init();
        return BlocBuilder<HomeCubit, NoteState>(
          builder: (context, noteState) {
            return Row(
              children: [
                if (noteState is NoteLoaded)
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<HomeCubit>(context)
                          .toggleNoteSort(isSorted: false, selectedId: '');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(
                          color: noteState.isSorted
                              ? secondryColor.withOpacity(0.5)
                              : secondryColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "All",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                color: Color(0xff262626),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${noteState.notes.length}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    children: [
                      if (state is CategoryLoaded)
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  print("noteState");
                                  BlocProvider.of<HomeCubit>(context)
                                      .toggleNoteSort(
                                          isSorted: true,
                                          selectedId:
                                              state.categories[index].parentId);
                                  print(state.categories[index].parentId);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
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
                ),
              ],
            );
          },
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
