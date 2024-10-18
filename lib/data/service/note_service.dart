import '../../common/firebase_lib.dart';
import '../../home/model/notes_model.dart';

class NoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  late CollectionReference userNotesRef;

  NoteService() {
    userNotesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('user_notes');
  }

  Future<void> createNote(NoteModel note) async {
    try {
      //  _hive.addTask(task: note);
      // await _firestore.collection('notes').doc().set(note.toMap());
      // await _firestore.collection('notes').doc().set(note.toMap());
      // fetchNotes(); // Refresh the list after creating a note

      // await _firestore.collection('user_notes').doc().set(note.toMap());

      // Add a new note to the subcollection
      await userNotesRef.add(note.toMap());
      print('Note created successfully for user: ${user!.uid}');
    } catch (e) {
      print('Went wrong: ${user!.uid}');
      print(e.toString());
    }
  }

  Future<void> updateNote({required NoteModel note}) async {
    try {
      await userNotesRef.doc(note.id).update(note.toMap());
      print('Note updated successfully for user: ${user!.uid}');
    } catch (e) {
      print('Failed to update note: ${e.toString()}');
    }
  }

  Future<List<NoteModel>> fetchAllNotes() async {
    List<NoteModel> note;
    try {
      QuerySnapshot querySnapshot = await userNotesRef.get();

      note = querySnapshot.docs.map((doc) {
        return NoteModel.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Error fetching notes: $e');
      return [];
    }

    return note;
  }

  Future<bool> deleteNote({required String noteId}) async {
    try {
      await userNotesRef.doc(noteId).delete();
      return true;
    } catch (e) {
      print('Error deleting note: $e');
      return false;
    }
  }
}
