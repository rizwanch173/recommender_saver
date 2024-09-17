import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recommender_saver/constants/colors.dart';
import 'package:uuid/uuid.dart';
import '../../data/service/note_service.dart';
import '../../repositories/note_repository.dart';
import '../model/notes_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<NoteState> {
  HomeCubit() : super(NoteInitial());

  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final HiveDataStore _hive = HiveDataStore();
  // final box = Hive.box<NoteModelHive>('notes');
  final uuid = Uuid();

  final NoteRepository _repository = NoteRepository(NoteService());

  Future<void> init() async {
    fetchNotesForUser();
  }

  @override
  Future<void> close() {
    // Perform any cleanup operations here
    // init();

    print("stop state close");
    return Future.value();
  }

  Future<void> updateLocal(
      {required int sortedNotesIndex, required NoteModel note}) async {
    if (state is NoteLoaded) {
      final currentState = state as NoteLoaded;

      // Clone the current lists
      final List<NoteModel> sortedNotes = List.from(currentState.sortedNotes);
      final List<NoteModel> notes = List.from(currentState.notes);

      // Update the note at the specific index in both lists
      sortedNotes[sortedNotesIndex] = note;

      // Find the index of the note in the `notes` list and update it
      final int notesIndex = notes.indexWhere((n) => n.id == note.id);
      if (notesIndex != -1) {
        notes[notesIndex] = note;
      }

      // Emit the updated state
      emit(NoteLoaded(notes: notes, sortedNotes: sortedNotes));

      print("NoteLoaded update called");
    }
  }

  void toggleNotesLoadedStyle() {
    if (state is NoteLoaded) {
      final currentState = state as NoteLoaded;
      emit(currentState.copyWith(isGrid: !currentState.isList));
      print("called");
    }
  }

  void toggleshowMenubar({required bool isClose}) {
    if (state is NoteLoaded) {
      final currentState = state as NoteLoaded;
      emit(currentState.copyWith(
          showMenubar: isClose ? false : !currentState.showMenubar));
      print("called");
    }
  }

  // void refreshNotes(NoteModel note) {
  //   fetchNotesForUser();

  //   print(state);
  //   if (state is NoteLoaded) {
  //     final currentState = state as NoteLoaded;

  //     currentState.sortedNotes.insert(0, note);

  //     print("currentState.sortedNotes.length");

  //     emit(currentState.copyWith(
  //       sortedNotes: currentState.sortedNotes,
  //     ));
  //   }
  // }

  // Future<void> createNote(NoteModel note, CategoryModel categoryModel) async {
  //   try {
  //     //  _hive.addTask(task: note);
  //     // await _firestore.collection('notes').doc().set(note.toMap());
  //     // await _firestore.collection('notes').doc().set(note.toMap());
  //     // fetchNotes(); // Refresh the list after creating a note

  //     await _firestore.collection('category').doc().set(categoryModel.toMap());
  //     fetchAllNotes();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // CategoryModel addAllCategoryCount() {
  //   return CategoryModel(
  //     cat_id: 'all',
  //     cat_name: 'All',
  //     createdAt: DateTime.now(),
  //   );
  // }

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  void toggleNoteSort({required bool isSorted, required String selectedId}) {
    if (state is NoteLoaded) {
      final currentState = state as NoteLoaded;

      List<NoteModel> sortedNotes = isSorted
          ? currentState.notes.where((note) {
              return note.parentId == selectedId;
            }).toList()
          : currentState.notes;

      if (!isClosed) {
        emit(currentState.copyWith(
            isSorted: isSorted,
            selectedId: selectedId,
            sortedNotes: sortedNotes));
      }

      print(currentState.selectedId);
    }
  }

  void onSearchTextChanged(String searchText) {
    if (state is NoteLoaded) {
      final currentState = state as NoteLoaded;

      List<NoteModel> tempSortedNotes = currentState.isSorted
          ? currentState.notes.where((note) {
              return note.parentId == currentState.selectedId;
            }).toList()
          : currentState.notes;

      if (searchText.isEmpty) {
        emit(currentState.copyWith(sortedNotes: currentState.notes));
      } else {
        List<NoteModel> sortedNotes = tempSortedNotes
            .where(
              (note) =>
                  note.name.toLowerCase().contains(
                        searchText.toLowerCase(),
                      ) ||
                  note.detail01.toLowerCase().contains(
                        searchText.toLowerCase(),
                      ) ||
                  note.detail02.toLowerCase().contains(
                        searchText.toLowerCase(),
                      ) ||
                  note.recommender.toLowerCase().contains(
                        searchText.toLowerCase(),
                      ),
            )
            .toList();
        if (!isClosed) {
          emit(currentState.copyWith(sortedNotes: sortedNotes));
        }
      }
    }
  }

  Future<List<NoteModel>> fetchAllNotes() async {
    List<NoteModel> noteX;
    noteX = await _repository.fetchAllNotes();
    emit(NoteLoaded(notes: noteX, sortedNotes: noteX));
    return noteX;
  }

  Future<void> deleteNote({required String noteId}) async {
    bool isDeleted = await _repository.deleteNote(noteId: noteId);

    if (isDeleted) {
      if (state is NoteLoaded) {
        final currentState = state as NoteLoaded;
        final updatedNotes =
            currentState.notes.where((note) => note.id != noteId).toList();

        final updatedSortedNotes = currentState.sortedNotes
            .where((note) => note.id != noteId)
            .toList();

        emit(currentState.copyWith(
            notes: updatedNotes, sortedNotes: updatedSortedNotes));
      }
    } else {
      // Handle failure case if needed
    }
  }

  // Future<List<NoteModel>> fetchAllCategory() async {
  //   CollectionReference collectionRef =
  //       FirebaseFirestore.instance.collection('category');

  //   QuerySnapshot querySnapshot = await collectionRef.get();
  //   List<CategoryModel> category = querySnapshot.docs.map((doc) {
  //     return CategoryModel.fromFirestore(doc);
  //   }).toList();

  //   emit(NoteLoaded(notes: noteX, category: category));

  //   return noteX;
  // }

  // List<NoteModel> getAllLocalNotes() {
  //   print("--------");
  //   print(box.values.toList().length);
  //   return box.values.toList();
  // }

  Future<void> fetchNotesForUser() async {
    try {
      emit(NoteLoading());
      final user = _auth.currentUser;
      if (user == null) throw Exception("User not signed in");
      List<NoteModel> notes = await _repository.fetchAllNotes();
      print("--------------------------");
      print(notes.length);
      emit(NoteLoaded(notes: notes, sortedNotes: notes));
    } catch (e) {
      emit(NoteError('Failed to fetch notes: $e'));
    }
  }
}

// Future<List<NoteModel>> fetchNotesForUser(String userId) async {
//   try {
//     // Reference to the user's notes subcollection
//     CollectionReference notesRef = FirebaseFirestore.instance
//         .collection('users')
//         .doc(userId)
//         .collection('notes');

//     // Fetch all notes documents
//     QuerySnapshot querySnapshot = await notesRef.get();

//     // Map the query results to a list of NoteModel
//     List<NoteModel> notes = querySnapshot.docs.map((doc) {
//       return NoteModel.fromFirestore(doc);
//     }).toList();

//     print('Fetched ${notes.length} notes for user: $userId');
//     return notes;
//   } catch (e) {
//     print('Error fetching notes: $e');
//     return [];
//   }
// }
