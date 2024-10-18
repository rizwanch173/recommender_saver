import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rebirth/rebirth.dart';
import 'package:recommender_saver/app/bloc_observer.dart';
import 'package:recommender_saver/app/view/app.dart';
import 'package:recommender_saver/firebase_options.dart';
import 'di/components/service_locator.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Bloc.observer = const AppBlocObserver();
//   await setupLocator();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   // // Initialize Hive
//   // await Hive.initFlutter();

//   // //adapters registration
//   // Hive.registerAdapter(HiveNoteModelAdapter());

//   // // Open the box with the correct type
//   // await Hive.openBox<NoteModel>('notes');

//   final authenticationRepository = AuthenticationRepository();
//   await authenticationRepository.user.first;
//   // Enable offline persistence
//   FirebaseFirestore.instance.settings =
//       const Settings(persistenceEnabled: true);
//   runApp(App(authenticationRepository: authenticationRepository));
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_firestore/firebase_firestore.dart';
// import 'your_project/repositories/authentication_repository.dart';
// import 'your_project/bloc_observer.dart';
// import 'your_project/app.dart';  // Your app widget

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await setupLocator();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Enable offline persistence for Firestore
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(WidgetRebirth(
    materialApp: App(authenticationRepository: authenticationRepository),
  ));

  // runApp(RestartWidget(
  //   child: App(authenticationRepository: authenticationRepository),
  // ));
}

class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({Key? key, required this.child}) : super(key: key);

  static void restartApp(BuildContext context) {
    print("Restart Requested");
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey(); // Change key to trigger app rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
