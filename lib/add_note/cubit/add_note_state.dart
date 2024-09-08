part of 'add_note_cubit.dart';

// sealed class AddNoteState extends Equatable {
//   const AddNoteState();

//   @override
//   List<Object> get props => [];
// }

// final class AddNoteInitial extends AddNoteState {}

final class AddNoteState extends Equatable {
  const AddNoteState({
    this.name,
    this.detail_01,
    this.detail_02,
    this.recommender,
    this.category_name,
    this.category_id,
    this.status = FormzSubmissionStatus.initial,
    this.note,
    this.errorMessage,
  });

  final FormzSubmissionStatus status;
  final String? note;
  final String? errorMessage;
  final String? name;
  final String? detail_01;
  final String? detail_02;
  final String? recommender;
  final String? category_name;
  final String? category_id;

  AddNoteState copyWith({
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
    return AddNoteState(
      name: name ?? this.name,
      detail_01: detail_01 ?? this.detail_01,
      detail_02: detail_01 ?? this.detail_02,
      recommender: recommender ?? this.recommender,
      category_name: recommender ?? this.category_name,
      category_id: category_id ?? this.category_id,
      status: status ?? this.status,
      note: note ?? this.note,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        name,
        detail_01,
        detail_02,
        category_name,
        recommender,
        category_id,
        status,
        note,
        errorMessage,
      ];
}
