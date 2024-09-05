import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

    _fetchAllCategory();
  }

  Future<bool> createCategory(categoryModel) async {
    if (await _repository.createCategory(categoryModel)) {
      print("success");
    }

    // emit(NoteLoaded(notes: noteX));

    return true;
  }

  Future<List<CategoryModel>> _fetchAllCategory() async {
    List<CategoryModel> categories;

    categories = await _repository.fetchAllCategory();

    emit(CategoryLoaded(categories: categories));

    return categories;
  }
}
