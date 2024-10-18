import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/common/dashed_line.dart';
import 'package:recommender_saver/edit_note/view/edit_note_page.dart';
import 'package:recommender_saver/home/cubit/home_cubit.dart';
import '../../category_selection/cubit/category_cubit.dart';
import '../../category_selection/models/category_model.dart';
import '../../common/animated_bar.dart';
import '../../common/glass_back_button.dart';
import '../../constants/colors.dart';
import '../model/notes_model.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class NoteDetailPage extends StatelessWidget {
  final HomeCubit homeCubit;
  NoteModel notesf;
  final int index;
  late CategoryModel? category;
  final String parentName;

  NoteDetailPage({
    super.key,
    required this.homeCubit,
    required this.index,
    required this.notesf,
    required this.parentName,
  });
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
            builder: (context, noteState) {
              //  print(noteState.notes[index].id)
              //int index = (noteState as NoteLoaded).sortedNotes.indexOf(notesf);
              noteState as NoteLoaded;

              return noteState.sortedNotes.length < 1
                  ? CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back Button with Glass Effect
                            GlassButton(
                              icon: Icons.arrow_back_ios_new_outlined,
                              onPressed: () {
                                Navigator.of(context).pop();
                                BlocProvider.of<HomeCubit>(context)
                                    .toggleshowMenubar(isClose: true);
                              },
                            ),
                            Text(
                              parentName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            // Share Button with Glass Effect
                            GlassButton(
                              icon: Icons.menu,
                              onPressed: () {
                                BlocProvider.of<HomeCubit>(context)
                                    .toggleshowMenubar(isClose: false);
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            AnimatedClipRect(
                              open: noteState.showMenubar,
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
                                      onPressed: () async {
                                        Navigator.of(context).pop();

                                        BlocProvider.of<HomeCubit>(context)
                                            .deleteNote(
                                                noteId:
                                                    noteState.notes[index].id);
                                      },
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    GlassButton(
                                      icon: Icons.edit,
                                      onPressed: () async {
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => EditNotePage(
                                              category: category!,
                                              note:
                                                  noteState.sortedNotes[index],
                                              index: index,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    GlassButton(
                                      icon: Icons.ios_share_outlined,
                                      onPressed: () {
                                        Share.share(
                                            'Budapest Hotel \n Quirky characters, colorful cinematography');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        BlocBuilder<CategoryCubit, CategoryState>(
                          builder: (context, state) {
                            if (state is CategoryLoaded)
                              try {
                                category = state.categories.firstWhere(
                                  (category) =>
                                      category.parentId ==
                                      noteState.sortedNotes[index].parentId,
                                );

                                print(category?.patent_name);
                              } catch (e) {
                                print("Category not found");
                              }
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 80, left: 20, right: 20),
                              child: Column(
                                children: [
                                  index < noteState.sortedNotes.length
                                      ? _NoteDetailWidget(
                                          note: noteState.sortedNotes[index],
                                          category: category!,
                                        )
                                      : SizedBox()

                                  // BlocBuilder<HomeCubit, NoteState>(
                                  //   builder: (context, state) {
                                  //     if (state is NoteLoaded) {
                                  //       return _NoteDetailWidget(
                                  //         note: state.notes[index],
                                  //         category: category!,
                                  //       );
                                  //     } else {
                                  //       return Center(
                                  //           child: CircularProgressIndicator());
                                  //     }
                                  //   },
                                  // ),
                                ],
                              ),
                            );
                          },
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

class _NoteDetailWidget extends StatelessWidget {
  const _NoteDetailWidget({
    required this.note,
    required this.category,
  });
  final NoteModel note;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _dataList(category.name, note.name),
                _dataList(category.detail_01, note.detail01),
                _dataList(category.detail_02, note.detail02),
                _dataList(category.Recommender, note.recommender),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DashedLine(),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    '${note.notes}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _dataList(String title, String data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Spacer(),
          Flexible(
            child: Text(
              '$data',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
