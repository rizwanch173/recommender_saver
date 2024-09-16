import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryAddModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String parentName;

  @HiveField(2)
  final String detail01;

  @HiveField(3)
  final String detail02;

  @HiveField(4)
  final String recommender;

  @HiveField(5)
  final String notes;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final String id;

  @HiveField(8)
  final String parentId;

  // Constructor with all required fields
  CategoryAddModel({
    this.parentId = '',
    required this.id,
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
      'id': id,
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
  factory CategoryAddModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CategoryAddModel(
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
