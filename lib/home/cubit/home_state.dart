part of 'home_cubit.dart';

abstract class NoteState {
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteDeleting extends NoteState {}

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
  final List<NoteModel> sortedNotes;
  final bool isSorted;
  final bool isList;
  final String selectedId;
  final bool showMenubar;

  // Constructor with a default value for isTrue
  NoteLoaded({
    this.selectedId = '',
    this.showMenubar = false,
    this.isSorted = false,
    this.isList = false,
    required this.sortedNotes,
    required this.notes,
  });

  // Create a copyWith method to update the state
  NoteLoaded copyWith({
    List<NoteModel>? notes,
    List<NoteModel>? sortedNotes,
    String? selectedId,
    bool? isSorted,
    bool? showMenubar,
    bool? isGrid,
  }) {
    return NoteLoaded(
      notes: notes ?? this.notes,
      selectedId: selectedId ?? this.selectedId,
      sortedNotes: sortedNotes ?? this.sortedNotes,
      isSorted: isSorted ?? this.isSorted,
      isList: isGrid ?? this.isList,
      showMenubar: showMenubar ?? this.showMenubar,
    );
  }

  @override
  List<Object> get props =>
      [notes, sortedNotes, isSorted, isList, selectedId, showMenubar];
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
