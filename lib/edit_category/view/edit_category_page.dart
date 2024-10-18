import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommender_saver/category_selection/cubit/category_cubit.dart';
import 'package:recommender_saver/category_selection/models/category_model.dart';
import 'package:recommender_saver/common/glass_back_button.dart';
import 'package:recommender_saver/constants/colors.dart';
import 'package:recommender_saver/edit_category/cubit/edit_category_cubit.dart';
import 'package:recommender_saver/edit_category/view/edit_category_form.dart';

class EditCategoryPage extends StatelessWidget {
  EditCategoryPage({
    super.key,
    required this.category,
    required this.index,
  });
  final CategoryModel category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: primaryColor,
        body: BlocProvider(
          create: (context) => EditCategoryCubit(
            context.read<CategoryCubit>(),
          )..init(
              categoryName: category.patent_name,
              the1stField: category.name,
              the2ndField: category.detail_01,
              the3rdField: category.detail_02,
              categoryId: category.id,
              categoryParentId: category.parentId,
              createdAt: category.createdAt,
            ),
          child: SingleChildScrollView(
            child: BlocBuilder<EditCategoryCubit, EditCategoryState>(
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
                          '',
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
                    EditCategoryForm(
                      category: category,
                      index: index,
                    )
                  ],
                );
              },
            ),
          ),
        ));
  }
}
