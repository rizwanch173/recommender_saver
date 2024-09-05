import 'package:recommender_saver/local_db/hive_data.dart';
import '../../common/firebase_lib.dart';

class NoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final HiveDataStore _hive = HiveDataStore();
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('notes');

  Future<void> createNote(NoteModel note) async {
    try {
      //  _hive.addTask(task: note);
      // await _firestore.collection('notes').doc().set(note.toMap());
      // await _firestore.collection('notes').doc().set(note.toMap());
      // fetchNotes(); // Refresh the list after creating a note

      await _firestore.collection('category').doc().set(note.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<NoteModel>> fetchAllNotes() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    List<NoteModel> noteX;
    noteX = querySnapshot.docs.map((doc) {
      return NoteModel.fromFirestore(doc);
    }).toList();
    return noteX;
  }
}
