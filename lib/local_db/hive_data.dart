import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recommender_saver/hive/notes.dart';
import 'package:recommender_saver/hive/task.dart';

class HiveDataStore {
  static const boxName = "notes";
  final Box<NoteModelHive> box = Hive.box<NoteModelHive>(boxName);

  /// Add new Task
  Future<void> addTask({required NoteModelHive task}) async {
    await box.add(task);
  }

  // /// Show task
  // Future<Task?> getTask({required String id}) async {
  //   return box.get(id);
  // }

  // /// Update task
  // Future<void> updateTask({required Task task}) async {
  //   await task.save();
  // }

  // /// Delete task
  // Future<void> dalateTask({required Task task}) async {
  //   await task.delete();
  // }

  // ValueListenable<Box<Task>> listenToTask() {
  //   return box.listenable();
  // }
}
