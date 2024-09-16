import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recommender_saver/constants/colors.dart';
import 'package:recommender_saver/edit_note/cubit/edit_note_cubit.dart';
import '../../category_selection/models/category_model.dart';
import '../../home/cubit/home_cubit.dart';

class EditNoteForm extends StatelessWidget {
  EditNoteForm({super.key, required this.category, required this.index});
  final CategoryModel category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditNoteCubit, EditNoteState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          // context.read<HomeCubit>().updateLocal(index: index, note: null, );

          Navigator.pop(context);
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage ?? 'Soemthing went wrong')),
            );
        }
      },
      child: BlocBuilder<EditNoteCubit, EditNoteState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<EditNoteCubit>(context);
          return Align(
            alignment: const Alignment(0, -1 / 3),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _customInput(
                    labelText: category.name,
                    controler: cubit.nameControler,
                  ),
                  const SizedBox(height: 25),
                  _customInput(
                    labelText: category.detail_01,
                    controler: cubit.detail01Controler,
                  ),
                  const SizedBox(height: 25),
                  _customInput(
                    labelText: category.detail_02,
                    controler: cubit.detail02Controler,
                  ),
                  const SizedBox(height: 25),
                  _customInput(
                    labelText: category.Recommender,
                    controler: cubit.recommenderControler,
                  ),
                  const SizedBox(height: 25),
                  _customInput(
                    labelText: category.Note,
                    controler: cubit.noteControler,
                  ),
                  const SizedBox(height: 25),
                  Align(
                    child: _AddButton(
                      index: index,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _nameInput extends StatelessWidget {
  final String labelText;
  final TextEditingController? controler;

  const _nameInput({required this.labelText, required this.controler});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 12),
          child: Text(
            'Please input ${labelText}',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
        NoteInputText(
          inputkey: '_nameInput_NoteInputText',
          labelText: '$labelText',
          controller: controler,
          onChanged: (value) {
            // Handle the change in input
          },
        ),
      ],
    );
  }
}

class _customInput extends StatelessWidget {
  final String labelText;
  final TextEditingController? controler;

  const _customInput({required this.labelText, required this.controler});

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
  final int index;

  const _AddButton({required this.index});
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (EditNoteCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress)
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: const CircularProgressIndicator(
          color: secondryColor,
        ),
      );

    return ElevatedButton(
      onPressed: () async {
        context.read<EditNoteCubit>().addFormSubmitted(index);
      },
      child: Text('Update'),
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

  // Constructor for NoteInputText
  const NoteInputText({
    this.inputkey,
    required this.labelText,
    this.helperText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.lines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: key,
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
