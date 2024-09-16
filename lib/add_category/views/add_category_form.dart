import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recommender_saver/common/dashed_line.dart';
import 'package:recommender_saver/constants/colors.dart';
import 'package:recommender_saver/home/home.dart';
import '../../category_selection/cubit/category_cubit.dart';
import '../../category_selection/view/category_selection_page.dart';
import '../cubit/add_category_cubit.dart';

class AddCategoryForm extends StatelessWidget {
  const AddCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCategoryCubit, AddCategoryState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.read<CategoryCubit>().fetchAllCategory();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CategorySelection(),
            ),
          );
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage ?? 'Soemthing went wrong')),
            );
        }
      },
      child: BlocBuilder<AddCategoryCubit, AddCategoryState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<AddCategoryCubit>(context);
          return Align(
            alignment: const Alignment(0, -1 / 3),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'To add new category please fill blew:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    _customInput(
                      labelText: 'Categoey name',
                      controler: cubit.categoryName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Categoey name is required';
                        }
                        if (value.length < 2) {
                          return 'Name too short';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    _customInput(
                      labelText: '1st field name',
                      controler: cubit.the1stField,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '1st field name is required';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    _customInput(
                      labelText: '2nd field name',
                      controler: cubit.the2ndField,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '2nd field name is required';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    _customInput(
                      labelText: '3rd field name',
                      controler: cubit.the3rdField,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '3rd field name is required';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'The Recommender & Additional notes are fixed',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DashedLine(),
                    ),
                    const SizedBox(height: 25),

                    // _customInput(
                    //   labelText: 'category.Recommender',
                    //   controler: cubit.recommenderControler,
                    // ),
                    // const SizedBox(height: 25),
                    // _customInput(
                    //   labelText: 'category.Note',
                    //   controler: cubit.noteControler,
                    // ),
                    const SizedBox(height: 25),
                    Align(
                      child: _AddButton(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// class _nameInput extends StatelessWidget {
//   final String labelText;
//   final TextEditingController? controler;

//   const _nameInput({required this.labelText, required this.controler});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 5, bottom: 12),
//           child: Text(
//             'Please input ${labelText}',
//             style: TextStyle(
//               fontWeight: FontWeight.normal,
//               color: Colors.white,
//               fontSize: 15,
//             ),
//           ),
//         ),
//         NoteInputText(
//           inputkey: '_nameInput_NoteInputText',
//           labelText: '$labelText',
//           controller: controler,
//           onChanged: (value) {
//             // Handle the change in input
//           },
//           validator: ve,
//         ),
//       ],
//     );
//   }
// }

class _customInput extends StatelessWidget {
  final String labelText;
  final TextEditingController? controler;
  final String? Function(String?) validator;

  const _customInput(
      {required this.labelText,
      required this.controler,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    // final displayError = context.select(
    //   (AddNoteCubit cubit) => cubit.state.status,
    // );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 12),
          child: Text(
            'Please input $labelText',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
        NoteInputText(
          inputkey: '__nameDetail01_NoteInputText',
          validator: validator,
          labelText: '$labelText',
          controller: controler,
          lines: labelText == 'notes' ? 3 : 1,
          onChanged: (value) {
            // Handle the change in input
          },
        ),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (AddCategoryCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress)
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: const CircularProgressIndicator(
          color: secondryColor,
        ),
      );

    return ElevatedButton(
      onPressed: () {
        context.read<AddCategoryCubit>().addFormSubmitted();
      },
      child: Text('Create'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(left: 50, right: 50),
        backgroundColor: secondryColor,
        textStyle: TextStyle(color: Colors.white),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4.0,
      ),
    );
  }
}

class NoteInputText extends StatelessWidget {
  final String labelText;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? inputkey;
  final int? lines;
  final String? Function(String?) validator;

  // Constructor for NoteInputText
  const NoteInputText({
    this.inputkey,
    required this.labelText,
    this.helperText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.lines = 1,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      maxLines: lines,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
              width: 1,
              color: secondryColor), // Replace secondryColor with actual color
        ),
        labelText: labelText == 'notes' ? '' : labelText,
        hintText: labelText,
        helperText: helperText,
        errorText: errorText,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
