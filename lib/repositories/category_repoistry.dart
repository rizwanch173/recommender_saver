import '../category_selection/models/category_model.dart';
import '../data/service/category_service.dart';

class CategoryRepoistry {
  final CategoryService _service;

  CategoryRepoistry(this._service);

  Future<List<CategoryModel>> fetchAllCategory() async =>
      await _service.fetch();

  Future<bool> createCategory(CategoryModel category) async =>
      await _service.create(category);

  Future<bool> deleteCategory({required String categoryId}) async =>
      await _service.delete(categoryId: categoryId);
}
