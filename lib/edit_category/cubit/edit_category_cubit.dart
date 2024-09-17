import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:recommender_saver/category_selection/cubit/category_cubit.dart';
import 'package:recommender_saver/category_selection/models/category_model.dart';
import 'package:recommender_saver/data/service/category_service.dart';
import 'package:recommender_saver/repositories/category_repoistry.dart';

part 'edit_category_state.dart';

class EditCategoryCubit extends Cubit<EditCategoryState> {
  EditCategoryCubit(this.categoryCubit) : super(EditCategoryState());

  TextEditingController? categoryName = TextEditingController();
  TextEditingController? the1stField = TextEditingController();
  TextEditingController? the2ndField = TextEditingController();
  TextEditingController? the3rdField = TextEditingController();

  final CategoryCubit categoryCubit;

  final formKey = GlobalKey<FormState>();
  final CategoryRepoistry _repository = CategoryRepoistry(CategoryService());

  late String categoryId;
  late String categoryParentId;
  late String createdAt;

  @override
  Future<void> close() {
    print("state close");
    return super.close();
  }

  Future<void> init({
    required String categoryName,
    required String the1stField,
    required String the2ndField,
    required String the3rdField,
    required String categoryId,
    required String categoryParentId,
    required String createdAt,
  }) async {
    this.categoryId = categoryId;
    this.categoryParentId = categoryParentId;
    this.createdAt = createdAt;

    this.categoryName?.text = categoryName;
    this.the1stField?.text = the1stField;
    this.the2ndField?.text = the2ndField;
    this.the3rdField?.text = the3rdField;
  }

  Future<void> addFormSubmitted(int index) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      CategoryModel categoryModel = CategoryModel(
          patent_name: categoryName!.text,
          name: the1stField!.text,
          detail_01: the2ndField!.text,
          detail_02: the3rdField!.text,
          Recommender: 'Recommender',
          Note: 'notes',
          createdAt: createdAt,
          id: categoryId,
          parentId: categoryParentId);

      try {
        await _repository.updateCategory(
          category: categoryModel,
          Id: categoryParentId,
        );
        print("updateCategory");
        categoryCubit.updateLocal(category: categoryModel, index: index);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        emit(
          state.copyWith(
              errorMessage: e.toString(),
              status: FormzSubmissionStatus.failure),
        );
      }
    } else {
      emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: "Form is not validated"));
    }
  }
}
