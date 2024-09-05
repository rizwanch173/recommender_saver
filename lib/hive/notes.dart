import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'notes.g.dart';

@HiveType(typeId: 1)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final DateTime createdAt;

  // Convert a Note into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  // Factory method to create a Note from a Firestore document
  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return NoteModel(
      id: doc.id, // Using document ID as note ID
      title: data['title'] ?? '', // Default to empty string if null
      content: data['content'] ?? '', // Default to empty string if null
      createdAt: DateTime.parse(
        data['createdAt'],
      ),
    );
  }
}
