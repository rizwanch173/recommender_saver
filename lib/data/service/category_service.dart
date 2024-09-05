import '../../category_selection/models/category_model.dart';
import '../../common/firebase_lib.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final HiveDataStore _hive = HiveDataStore();
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('default_category');

  Future<bool> createCategory(CategoryModel category) async {
    try {
      await _firestore
          .collection('default_category')
          .doc()
          .set(category.toMap());

      print("default_category created");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<List<CategoryModel>> fetchAllCategory() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    List<CategoryModel> noteX;
    noteX = querySnapshot.docs.map((doc) {
      return CategoryModel.fromFirestore(doc);
    }).toList();
    return noteX;
  }
}
