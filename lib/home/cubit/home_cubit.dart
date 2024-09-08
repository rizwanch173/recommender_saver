import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    // fetchAllNotes();
    fetchNotesForUser();
  }

  void toggleNotesLoadedStyle() {
    if (state is NoteLoaded) {
      final currentState = state as NoteLoaded;
      emit(currentState.copyWith(isGrid: !currentState.isList));
      print("called");
    }
  }

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
      if (!isClosed) {
        emit(currentState.copyWith(isSorted: isSorted, selectedId: selectedId));
      }

      print(currentState.selectedId);
    }
  }

  Future<List<NoteModel>> fetchAllNotes() async {
    List<NoteModel> noteX;
    noteX = await _repository.fetchAllNotes();
    emit(NoteLoaded(notes: noteX, sortedNotes: noteX));
    return noteX;
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
      emit(NoteLoaded(notes: notes, sortedNotes: notes));
    } catch (e) {
      emit(NoteError('Failed to fetch notes: $e'));
    }
  }
}

Future<List<NoteModel>> fetchNotesForUser(String userId) async {
  try {
    // Reference to the user's notes subcollection
    CollectionReference notesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notes');

    // Fetch all notes documents
    QuerySnapshot querySnapshot = await notesRef.get();

    // Map the query results to a list of NoteModel
    List<NoteModel> notes = querySnapshot.docs.map((doc) {
      return NoteModel.fromFirestore(doc);
    }).toList();

    print('Fetched ${notes.length} notes for user: $userId');
    return notes;
  } catch (e) {
    print('Error fetching notes: $e');
    return [];
  }
}
