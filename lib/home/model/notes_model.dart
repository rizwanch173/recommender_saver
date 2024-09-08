import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'notes_model.g.dart';

@HiveType(typeId: 1)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String parentId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String parentName;

  @HiveField(3)
  final String detail01;

  @HiveField(4)
  final String detail02;

  @HiveField(5)
  final String recommender;

  @HiveField(6)
  final String notes;

  @HiveField(7)
  final DateTime createdAt;

  @HiveField(8)
  final String id;

  // Constructor with all required fields
  NoteModel({
    this.id = '',
    required this.parentId,
    required this.name,
    required this.parentName,
    required this.detail01,
    required this.detail02,
    required this.recommender,
    required this.notes,
    required this.createdAt,
  });

  // Convert a Note into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': parentId,
      'name': name,
      'patent_name': parentName,
      'detail_01': detail01,
      'detail_02': detail02,
      'Recommender': recommender,
      'Note': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Factory method to create a Note from a Firestore document
  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return NoteModel(
      id: doc.id, // Using document ID as note ID
      parentId: data['id'] ?? '',
      name: data['name'] ?? '', // Default to empty string if null
      parentName: data['patent_name'] ?? '', // Default to empty string if null
      detail01: data['detail_01'] ?? '', // Default to empty string if null
      detail02: data['detail_02'] ?? '', // Default to empty string if null
      recommender: data['Recommender'] ?? '', // Default to empty string if null
      notes: data['Note'] ?? '', // Default to empty string if null
      createdAt: DateTime.parse(data['createdAt'] ??
          DateTime.now().toIso8601String()), // Default to current time if null
    );
  }
}
