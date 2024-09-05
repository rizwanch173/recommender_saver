part of 'home_cubit.dart';

abstract class NoteState {
  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

// class NoteLoaded extends NoteState {
//   final List<NoteModel> notes;

//   NoteLoaded(this.notes);

//   NoteLoaded copyWith({
//     List<NoteModel>? notes,
//   }) {
//     return NoteLoaded(notes ?? this.notes);
//   }

//   @override
//   List<Object> get props => [notes];
// }

// Define a state when notes are loaded with isTrue value
class NoteLoaded extends NoteState {
  final List<NoteModel> notes;
  final bool isTrue; // Add isTrue with a default value

  // Constructor with a default value for isTrue
  NoteLoaded({required this.notes, this.isTrue = false});

  // Create a copyWith method to update the state
  NoteLoaded copyWith(
      {List<NoteModel>? notes, List<CategoryModel>? category, bool? isTrue}) {
    return NoteLoaded(
      notes: notes ?? this.notes,
      isTrue: isTrue ?? this.isTrue,
    );
  }

  @override
  List<Object> get props => [notes];
}

class NoteError extends NoteState {
  final String message;

  NoteError(this.message);

  @override
  List<Object> get props => [message];
}

// Define a new state with a boolean isTrue value
class NoteStyleState extends NoteState {
  final bool isTrue;

  // Constructor with a default value for isTrue
  NoteStyleState({this.isTrue = true});

  // Create a copyWith method to update the state
  NoteStyleState copyWith({bool? isTrue}) {
    return NoteStyleState(
      isTrue: isTrue ?? this.isTrue,
    );
  }
}
