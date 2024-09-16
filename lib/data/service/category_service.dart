import '../../category_selection/models/category_model.dart';
import '../../common/firebase_lib.dart';

class CategoryService {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final HiveDataStore _hive = HiveDataStore();
  late CollectionReference collectionRef;
  late CollectionReference collectionRefNotes;

  CategoryService() {
    collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('categories');

    collectionRefNotes = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('user_notes');
  }

  Future<bool> create(CategoryModel category) async {
    try {
      await collectionRef.doc().set(category.toMap());

      print("category created");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<List<CategoryModel>> fetch() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    List<CategoryModel> noteX;
    noteX = querySnapshot.docs.map((doc) {
      return CategoryModel.fromFirestore(doc);
    }).toList();
    return noteX;
  }

  Future<bool> delete({required String categoryId}) async {
    try {
      // await collectionRef.doc(categoryId).delete();

      print("collectionRef.doc(categoryId).delete()");

      // Create a batch instance
      WriteBatch batch = FirebaseFirestore.instance.batch();

      // Get all notes under the category
      QuerySnapshot notesSnapshot =
          await collectionRefNotes.where('id', isEqualTo: categoryId).get();

      // Add each note delete operation to the batch
      for (QueryDocumentSnapshot note in notesSnapshot.docs) {
        batch.delete(note.reference);
      }

      // Add category delete operation to the batch
      DocumentReference categoryDocRef = collectionRef.doc(categoryId);
      batch.delete(categoryDocRef);

      // for (var doc in notesSnapshot.docs) {
      //   // Print the document data
      //   print(doc.data());
      // }

      // Commit the batch
      await batch.commit();
      print('Category and all associated notes deleted successfully.');

      return true;
    } catch (e) {
      print('Error deleting note: $e');
      return false;
    }
  }
}

Future<void> deleteCategoryAndNotes(String categoryId) async {
  final CollectionReference categoriesRef =
      FirebaseFirestore.instance.collection('categories');
  final CollectionReference notesRef =
      FirebaseFirestore.instance.collection('notes');

  // Create a batch instance
  WriteBatch batch = FirebaseFirestore.instance.batch();

  try {
    // Get all notes under the category
    QuerySnapshot notesSnapshot =
        await notesRef.where('categoryId', isEqualTo: categoryId).get();

    // Add each note delete operation to the batch
    for (QueryDocumentSnapshot note in notesSnapshot.docs) {
      batch.delete(note.reference);
    }

    // Add category delete operation to the batch
    DocumentReference categoryDocRef = categoriesRef.doc(categoryId);
    batch.delete(categoryDocRef);

    // Commit the batch
    await batch.commit();
    print('Category and all associated notes deleted successfully.');
  } catch (e) {
    print('Error deleting category and notes: $e');
  }
}
