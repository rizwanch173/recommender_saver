import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recommender_saver/app/bloc_observer.dart';
import 'package:recommender_saver/app/view/app.dart';
import 'package:recommender_saver/firebase_options.dart';
import 'package:recommender_saver/hive/notes.dart';

import 'di/components/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // // Initialize Hive
  // await Hive.initFlutter();

  // //adapters registration
  // Hive.registerAdapter(HiveNoteModelAdapter());

  // // Open the box with the correct type
  // await Hive.openBox<NoteModel>('notes');

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  // Enable offline persistence
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp(App(authenticationRepository: authenticationRepository));
}
