import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:recommender_saver/common/firebase_lib.dart';
import 'package:recommender_saver/data/service/category_service.dart';
import 'package:recommender_saver/repositories/category_repoistry.dart';
import 'package:uuid/uuid.dart';

import '../models/category_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  final CategoryRepoistry _repository = CategoryRepoistry(CategoryService());
  final uuid = Uuid();

  Future<void> init() async {
    // CategoryModel categoryModel = CategoryModel(
    //   id: uuid.v4(),
    //   patent_name: 'Miscellaneous',
    //   name: 'Name',
    //   detail_01: 'link',
    //   detail_02: 'Category',
    //   Recommender: 'Recommender',
    //   Note: 'notes',
    //   createdAt: DateTime.now(),
    // );

    fetchAllCategory();
  }

  Future<bool> createCategory(categoryModel) async {
    if (await _repository.createCategory(categoryModel)) {
      print("success");
    }
    return true;
  }

  Future<void> logout() {
    return super.close();
  }

  Future<void> updateLocal(
      {required int index, required CategoryModel category}) async {
    if (state is CategoryLoaded) {
      final currentState = state as CategoryLoaded;

      final List<CategoryModel> categories = List.from(currentState.categories);

      // Update the note at the specific index in both lists
      categories[index] = category;

      // Emit the updated state
      emit(CategoryLoaded(categories: categories));

      print("CategoryLoaded update called");
    }
  }

  Future<List<CategoryModel>> fetchAllCategory() async {
    List<CategoryModel> categories;

    categories = await _repository.fetchAllCategory();

    if (!isClosed) {
      emit(CategoryLoaded(categories: categories));
    }

    return categories;
  }

  Future<void> deleteCategory({required String categoryId}) async {
    bool isDeleted = await _repository.deleteCategory(categoryId: categoryId);

    if (isDeleted) {
      if (state is CategoryLoaded) {
        final currentState = state as CategoryLoaded;
        final updatedCategory = currentState.categories
            .where((category) => category.parentId != categoryId)
            .toList();

        emit(
          currentState.copyWith(categories: updatedCategory),
        );
      }
    } else {
      // Handle failure case if needed
    }

    toggleshowMenubar(isMenuShow: false, selectedIndex: -1);
  }

  //   // Method to update categories
  // void updateLocalCategories(List<CategoryModel> newCategories) {
  //   if (state is CategoryLoaded) {
  //     final currentState = state as CategoryLoaded;
  //     emit(currentState.copyWith(categories: newCategories));
  //   }
  // }

  void toggleshowMenubar(
      {required bool isMenuShow, required int selectedIndex}) {
    if (state is CategoryLoaded) {
      final currentState = state as CategoryLoaded;
      emit(currentState.copyWith(
          isMenuShow: isMenuShow, selectedIndex: selectedIndex));
      print("called");
    }
  }
}
