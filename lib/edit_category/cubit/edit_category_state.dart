part of 'edit_category_cubit.dart';

class EditCategoryState extends Equatable {
  const EditCategoryState({
    this.the3rdField,
    this.the1stField,
    this.the2ndField,
    this.recommender,
    this.category_name,
    this.status = FormzSubmissionStatus.initial,
    this.note,
    this.errorMessage,
  });

  final FormzSubmissionStatus status;
  final String? the1stField;
  final String? the2ndField;
  final String? the3rdField;
  final String? note;
  final String? errorMessage;
  final String? recommender;

  final String? category_name;

  EditCategoryState copyWith({
    FormzSubmissionStatus? status,
    String? note,
    String? errorMessage,
    String? name,
    String? detail_01,
    String? detail_02,
    String? recommender,
    String? category_name,
    String? category_id,
  }) {
    return EditCategoryState(
      the1stField: the1stField ?? this.the1stField,
      the2ndField: the2ndField ?? this.the2ndField,
      the3rdField: the3rdField ?? this.the3rdField,
      recommender: recommender ?? this.recommender,
      category_name: recommender ?? this.category_name,
      status: status ?? this.status,
      note: note ?? this.note,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        the1stField,
        the2ndField,
        the3rdField,
        category_name,
        recommender,
        status,
        note,
        errorMessage,
      ];
}
