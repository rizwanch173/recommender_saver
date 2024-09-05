import 'package:get_it/get_it.dart';
import 'package:recommender_saver/data/service/note_service.dart';

import '../../common/firebase_lib.dart';
import '../../repositories/note_repository.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  // Register FirebaseAuth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Register Firestore
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  // getIt.registerSingleton(NoteRepository(getIt<NoteService>()));

  // getIt.registerSingleton(NoteService(getIt<NoteService>()));
}
