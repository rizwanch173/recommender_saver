import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:recommender_saver/constants/colors.dart';
import 'package:recommender_saver/category_selection/models/category_model.dart';
import 'package:recommender_saver/hive/notes.dart';
import 'package:recommender_saver/local_db/hive_data.dart';
import 'package:uuid/uuid.dart';

import '../../data/service/note_service.dart';
import '../../di/components/service_locator.dart';
import '../../repositories/note_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<NoteState> {
  HomeCubit() : super(NoteInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final HiveDataStore _hive = HiveDataStore();
  final box = Hive.box<NoteModel>('notes');
  final uuid = Uuid();

  final NoteRepository _repository = NoteRepository(NoteService());

  Future<void> init() async {
    NoteModel note = NoteModel(
      id: user!.uid,
      title: 'my note xx',
      content: 'jhfe ffh ehfiuf',
      createdAt: DateTime.now(),
    );

    fetchAllNotes();

    // createNote(note, categoryModel);
  }

  void toggleNotesLoadedStyle() {
    if (state is NoteLoaded) {
      final currentState = state as NoteLoaded;
      emit(currentState.copyWith(isTrue: !currentState.isTrue));
      print("called");
    }
  }

  Future<void> createNote(NoteModel note, CategoryModel categoryModel) async {
    try {
      //  _hive.addTask(task: note);
      // await _firestore.collection('notes').doc().set(note.toMap());
      // await _firestore.collection('notes').doc().set(note.toMap());
      // fetchNotes(); // Refresh the list after creating a note

      await _firestore.collection('category').doc().set(categoryModel.toMap());
      fetchAllNotes();
    } catch (e) {
      print(e.toString());
    }
  }

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

  Future<List<NoteModel>> fetchAllNotes() async {
    List<NoteModel> noteX;

    noteX = await _repository.fetchAllNotes();

    emit(NoteLoaded(notes: noteX));

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

  List<NoteModel> getAllLocalNotes() {
    print("--------");
    print(box.values.toList().length);
    return box.values.toList();
  }

  Future<void> fetchNotes() async {
    try {
      emit(NoteLoading());

      final user = _auth.currentUser;
      if (user == null) throw Exception("User not signed in");

      final querySnapshot = await _firestore.collection('notes');

      // final notes = querySnapshot.data() as Map<String, dynamic>;

      print(querySnapshot.doc());

      // final note = Note.fromDoc(querySnapshot.doc() as Map<String, dynamic>);
      // print(note);

      // emit(NoteLoaded(note));
    } catch (e) {
      emit(NoteError('Failed to fetch notes: $e'));
    }
  }
}

// class Note {
//   String id;
//   String title;
//   String content;
//   DateTime createdAt;

//   Note({
//     required this.id,
//     required this.title,
//     required this.content,
//     required this.createdAt,
//   });

//   // Convert a Note into a Map
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'content': content,
//       'createdAt': createdAt.toIso8601String(),
//     };
//   }

//   // Create a Note from a Firestore document snapshot
//   factory Note.fromDoc(Map<String, dynamic> doc) {
//     return Note(
//       id: doc['id'],
//       title: doc['title'],
//       content: doc['content'],
//       createdAt: DateTime.parse(doc['createdAt']),
//     );
//   }

//   // Factory method to create a Note from a Firestore document
//   factory Note.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return Note(
//       id: doc.id, // Using document ID as note ID
//       title: data['title'] ?? '', // Default to empty string if null
//       content: data['content'] ?? '', // Default to empty string if null
//       createdAt: DateTime.parse(data['createdAt']),
//     );
//   }
// }
