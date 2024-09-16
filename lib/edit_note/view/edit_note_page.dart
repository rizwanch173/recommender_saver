import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/constants/colors.dart';
import 'package:recommender_saver/edit_note/cubit/edit_note_cubit.dart';
import 'package:recommender_saver/edit_note/view/edit_note_form.dart';
import 'package:recommender_saver/home/cubit/home_cubit.dart';
import 'package:recommender_saver/home/model/notes_model.dart';
import '../../category_selection/models/category_model.dart';
import '../../common/glass_back_button.dart';

class EditNotePage extends StatelessWidget {
  EditNotePage({
    super.key,
    required this.category,
    required this.note,
    required this.index,
  });
  final CategoryModel category;
  final NoteModel note;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: BlocProvider(
          create: (context) => EditNoteCubit(
            context.read<HomeCubit>(),
          )..init(
              categoryId: category.parentId,
              categoryName: category.patent_name,
              nameControler: note.name,
              detail01Controler: note.detail01,
              detail02Controler: note.detail02,
              recommenderControler: note.recommender,
              noteControler: note.notes,
              noteId: note.id,
            ),
          child: BlocBuilder<EditNoteCubit, EditNoteState>(
            builder: (context, state) {
              // final cubit = BlocProvider.of<AddNoteCubit>(context);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: GlassButton(
                          icon: Icons.arrow_back_ios_new_outlined,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Text(
                        '${category.patent_name}',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  EditNoteForm(
                    category: category,
                    index: index,
                  )
                ],
              );
            },
          ),
        ));
  }
}
