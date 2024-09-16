part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  final bool isMenuShow;
  final int selectedIndex;
  final FormzSubmissionStatus status;

  CategoryLoaded({
    required this.categories,
    this.isMenuShow = false,
    this.selectedIndex = -1,
    this.status = FormzSubmissionStatus.success,
  });

  @override
  List<Object> get props => [categories, isMenuShow, selectedIndex];

  CategoryLoaded copyWith({
    List<CategoryModel>? categories,
    bool? isMenuShow,
    int? selectedIndex,
    FormzSubmissionStatus? status,
  }) {
    return CategoryLoaded(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      isMenuShow: isMenuShow ?? this.isMenuShow,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
