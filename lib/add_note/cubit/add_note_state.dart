part of 'add_note_cubit.dart';

final class AddNoteState extends Equatable {
  const AddNoteState({
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final FormzSubmissionStatus status;
  final String? errorMessage;

  AddNoteState copyWith({
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return AddNoteState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
      ];
}
