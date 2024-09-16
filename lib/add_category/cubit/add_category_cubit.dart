import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:recommender_saver/repositories/category_repoistry.dart';
import 'package:uuid/uuid.dart' as uuid;
import 'package:recommender_saver/category_selection/models/category_model.dart';

import '../../data/service/category_service.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit() : super(AddCategoryState());

  TextEditingController? categoryName = TextEditingController();
  TextEditingController? the1stField = TextEditingController();
  TextEditingController? the2ndField = TextEditingController();
  TextEditingController? the3rdField = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final CategoryRepoistry _repository = CategoryRepoistry(CategoryService());

  Future<void> init() async {}

  Future<void> addFormSubmitted() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      CategoryModel categoryModel = CategoryModel(
        patent_name: categoryName!.text,
        name: the1stField!.text,
        detail_01: the2ndField!.text,
        detail_02: the3rdField!.text,
        Recommender: 'Recommender',
        Note: 'notes',
        createdAt: DateTime.now().toIso8601String(),
        id: uuid.Uuid().v4(),
      );

      try {
        await _repository.createCategory(categoryModel);

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        emit(
          state.copyWith(
              errorMessage: e.toString(),
              status: FormzSubmissionStatus.failure),
        );
      }
    }
  }
}
