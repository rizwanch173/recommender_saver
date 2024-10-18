import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../common/firebase_lib.dart';
import '../../data/service/note_service.dart';
import '../../home/cubit/home_cubit.dart';
import '../../home/model/notes_model.dart';
import '../../repositories/note_repository.dart';

part 'edit_note_state.dart';

class EditNoteCubit extends Cubit<EditNoteState> {
  EditNoteCubit(this.noteCubit) : super(EditNoteState());

  TextEditingController? nameControler = TextEditingController();
  TextEditingController? detail01Controler = TextEditingController();
  TextEditingController? detail02Controler = TextEditingController();
  TextEditingController? recommenderControler = TextEditingController();
  TextEditingController? noteControler = TextEditingController();
  final NoteRepository _repository = NoteRepository(NoteService());
  final user = FirebaseAuth.instance.currentUser;
  final HomeCubit noteCubit; // Reference to NoteCubit

  late String categoryId;
  late String categoryName;
  late String noteId;

  NoteModel? updatedNote;

  Future<void> init({
    required String categoryId,
    required String categoryName,
    required String noteId,
    required String nameControler,
    required String detail01Controler,
    required String detail02Controler,
    required String recommenderControler,
    required String noteControler,
  }) async {
    // Assign values to the class-level properties
    this.categoryId = categoryId;
    this.categoryName = categoryName;
    this.noteId = noteId;

    // Initialize the text controllers with the provided values
    this.nameControler?.text = nameControler;
    this.detail01Controler?.text = detail01Controler;
    this.detail02Controler?.text = detail02Controler;
    this.recommenderControler?.text = recommenderControler;
    this.noteControler?.text = noteControler;
  }

  Future<NoteModel> addFormSubmitted(int index) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    NoteModel note = NoteModel(
      id: noteId,
      parentId: categoryId,
      name: nameControler!.text,
      parentName: categoryName,
      detail01: detail01Controler!.text,
      detail02: detail02Controler!.text,
      recommender: recommenderControler!.text,
      notes: noteControler!.text,
      createdAt: DateTime.now(),
    );

    try {
      await _repository.updateNote(note: note);
      noteCubit.updateLocal(note: note, sortedNotesIndex: index);
      updatedNote = note;
      emit(state.copyWith(status: FormzSubmissionStatus.success));
      return note;
    } catch (e) {
      emit(
        state.copyWith(
            errorMessage: e.toString(), status: FormzSubmissionStatus.failure),
      );
      return note;
    }
  }
}
