import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/category_selection/cubit/category_cubit.dart';
import 'package:recommender_saver/common/glass_back_button.dart';
import 'package:recommender_saver/constants/colors.dart';
import 'package:recommender_saver/home/cubit/home_cubit.dart';
import 'package:recommender_saver/home/view/home_page.dart';
import 'package:recommender_saver/home/view/note_detail.dart';

class DrawerNotes extends StatelessWidget {
  DrawerNotes(
      {super.key, required this.categoryName, required this.categoryId});

  final String categoryName;
  final String categoryId;
  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 60.0),
        child: BlocBuilder<HomeCubit, NoteState>(
          builder: (context, state) {
            final cubit = BlocProvider.of<HomeCubit>(context);
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GlassButton(
                      icon: Icons.arrow_back_ios_new_outlined,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      categoryName,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    // GlassButton(
                    //   icon: Icons.delete,
                    //   onPressed: () {
                    //     showCupertinoDialog(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return CupertinoAlertDialog(
                    //           key: _dialogKey, // Attach the key here

                    //           title: Text('Are you sure?'),
                    //           content: Text(
                    //             'Caution: This will delete all the notes associated with this category.',
                    //           ),
                    //           actions: <CupertinoDialogAction>[
                    //             CupertinoDialogAction(
                    //               child: Text(
                    //                 'Cancel',
                    //                 style: TextStyle(color: Colors.black),
                    //               ),
                    //               onPressed: () {
                    //                 Navigator.of(context)
                    //                     .pop(); // Close the dialog
                    //               },
                    //             ),
                    //             CupertinoDialogAction(
                    //               isDestructiveAction:
                    //                   true, // Highlight as destructive action
                    //               child: Text(
                    //                 'Delete',
                    //               ),
                    //               onPressed: () async {
                    //                 BlocProvider.of<CategoryCubit>(context)
                    //                     .deleteCategory(categoryId: categoryId)
                    //                     .then((_) {
                    //                   Navigator.of(context).pop();
                    //                 });

                    //                 context.read<HomeCubit>().init();
                    //               },
                    //             ),
                    //           ],
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),
                    SizedBox(
                      width: 40,
                    )
                  ],
                ),
                if (state is NoteLoaded)
                  if (state.sortedNotes.length < 1)
                    Expanded(
                      child: Center(
                        child: Text(
                          "No Notes found",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200, // Max width for each item
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.4,
                        ),
                        // gridDelegate:
                        //     SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 2,
                        //   crossAxisSpacing: 12,
                        //   mainAxisSpacing: 12,
                        //   childAspectRatio: 1.4,
                        // ),
                        itemBuilder: (_, index) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NoteDetailPage(
                                  homeCubit: cubit,
                                  index: index,
                                  notesf: state.sortedNotes[index],
                                  parentName:
                                      state.sortedNotes[index].parentName,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            child: HomeWidget(
                              index: index,
                              notes: state.sortedNotes[index],
                            ),
                          ),
                        ),
                        itemCount: state.sortedNotes.length,
                      ),
                    )
              ],
            );
          },
        ),
      ),
    );
  }
}
