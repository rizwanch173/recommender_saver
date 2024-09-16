import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/common/animated_bar.dart';
import 'package:recommender_saver/common/glass_back_button.dart';
import 'package:recommender_saver/home/cubit/home_cubit.dart';

import '../category_selection/cubit/category_cubit.dart';
import '../category_selection/models/category_model.dart';
import '../constants/colors.dart';

class CategorySelectionWidget extends StatelessWidget {
  final CategoryModel category;
  final int index;

  const CategorySelectionWidget({required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: secondryColor.withOpacity(0.5),
            ),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category.patent_name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  if (state is CategoryLoaded)
                    if (state.selectedIndex != index)
                      IconButton(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        constraints: BoxConstraints(),
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // the '2023' part
                        ),
                        icon: Icon(
                          Icons.more_vert,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          BlocProvider.of<CategoryCubit>(context)
                              .toggleshowMenubar(
                                  isMenuShow: true, selectedIndex: index);
                        },
                      )
                    else
                      IconButton(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        constraints: BoxConstraints(),
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // the '2023' part
                        ),
                        icon: Icon(
                          Icons.cancel,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          BlocProvider.of<CategoryCubit>(context)
                              .toggleshowMenubar(
                                  isMenuShow: false, selectedIndex: -1);
                        },
                      )
                ],
              ),
              Column(
                children: <Widget>[
                  if (state is CategoryLoaded)
                    AnimatedClipRect(
                      open: (state.isMenuShow && state.selectedIndex == index),
                      horizontalAnimation: false,
                      verticalAnimation: true,
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.bounceOut,
                      reverseCurve: Curves.bounceIn,
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GlassButton(
                              icon: Icons.delete,
                              onPressed: () {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      title: Text('Are you sure?'),
                                      content: Text(
                                        'Caution: This will delete all the notes associated with this category.',
                                      ),
                                      actions: <CupertinoDialogAction>[
                                        CupertinoDialogAction(
                                          child: Text(
                                            'Cancel',
                                            style:
                                                TextStyle(color: secondryColor),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                        ),
                                        CupertinoDialogAction(
                                          isDestructiveAction:
                                              true, // Highlight as destructive action
                                          child: Text(
                                            'Delete',
                                          ),
                                          onPressed: () async {
                                            await BlocProvider.of<
                                                    CategoryCubit>(context)
                                                .deleteCategory(
                                                    categoryId:
                                                        category.parentId);
                                            Navigator.of(context).pop();
                                            context.read<HomeCubit>().init();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            // SizedBox(
                            //   width: 15,
                            // ),
                            // GlassButton(
                            //   icon: Icons.edit,
                            //   onPressed: () {},
                            // ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
