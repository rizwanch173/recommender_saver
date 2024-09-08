import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/add_note/note_view.dart';
import 'package:recommender_saver/add_note/view/add_note_form.dart';
import 'package:recommender_saver/constants/colors.dart';
import '../../category_selection/models/category_model.dart';
import '../../common/glass_back_button.dart';

class AddNotePage extends StatelessWidget {
  AddNotePage({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: BlocProvider(
          create: (context) => AddNoteCubit()
            ..init(
              categoryId: category.id,
              categoryName: category.patent_name,
            ),
          child: BlocBuilder<AddNoteCubit, AddNoteState>(
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
                  AddNoteForm(category: category)
                ],
              );
            },
          ),
        ));
  }
}
