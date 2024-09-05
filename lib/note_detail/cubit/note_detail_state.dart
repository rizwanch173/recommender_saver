part of 'note_detail_cubit.dart';

sealed class NoteDetailState extends Equatable {
  const NoteDetailState();

  @override
  List<Object> get props => [];
}

final class NoteDetailInitial extends NoteDetailState {}

class NoteDetailLoaded extends NoteDetailState {
  final NoteModel note;
  final bool isTrue;

  NoteDetailLoaded({required this.note, this.isTrue = false});

  // Create a copyWith method to update the state
  NoteDetailLoaded copyWith({NoteModel? notes, bool? isTrue}) {
    return NoteDetailLoaded(
      note: notes ?? this.note,
      isTrue: isTrue ?? this.isTrue,
    );
  }

  @override
  List<Object> get props => [note];
}
