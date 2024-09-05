part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  final bool isTrue;
  CategoryLoaded({required this.categories, this.isTrue = false});

  @override
  List<Object> get props => [categories];
}
