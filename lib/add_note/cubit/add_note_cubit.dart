import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';
import '../../common/firebase_lib.dart';
import '../../data/service/note_service.dart';
import '../../home/model/notes_model.dart';
import '../../repositories/note_repository.dart';
part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(const AddNoteState());

  TextEditingController? nameControler = TextEditingController();
  TextEditingController? detail01Controler = TextEditingController();
  TextEditingController? detail02Controler = TextEditingController();
  TextEditingController? recommenderControler = TextEditingController();
  TextEditingController? noteControler = TextEditingController();
  final NoteRepository _repository = NoteRepository(NoteService());
  final user = FirebaseAuth.instance.currentUser;

  late String categoryId;
  late String categoryName;

  Future<void> init(
      {required String categoryId, required String categoryName}) async {
    this.categoryId = categoryId;
    this.categoryName = categoryName;
  }

  // void netail01Change(String value) {
  //   emit(
  //     state.copyWith(
  //       detail_01: value,
  //     ),
  //   );
  // }

  Future<void> addFormSubmitted() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    NoteModel note = NoteModel(
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
      await _repository.createNote(note: note);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
            errorMessage: e.toString(), status: FormzSubmissionStatus.failure),
      );
    }
  }
}
