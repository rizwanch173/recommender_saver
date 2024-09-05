import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

//part 'category_model.g.dart';
@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String detail_01;
  @HiveField(3)
  final String detail_02;
  @HiveField(4)
  final String Recommender;
  @HiveField(5)
  final String Note;
  @HiveField(6)
  final String createdAt;
  @HiveField(7)
  final String patent_name;

  // Convert a CategoryModel into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'patent_name': patent_name,
      'detail_01': detail_01,
      'detail_02': detail_02,
      'Recommender': Recommender,
      'Note': Note,
      'created_at': createdAt,
    };
  }

  // Constructor
  CategoryModel({
    required this.patent_name,
    required this.id,
    required this.name,
    required this.detail_01,
    required this.detail_02,
    required this.Recommender,
    required this.Note,
    required this.createdAt,
  });

  // Factory method to create a CategoryModel from a Firestore document
  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CategoryModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      detail_01: data['detail_01'] ?? '',
      detail_02: data['detail_02'] ?? '',
      Recommender: data['Recommender'] ?? '',
      Note: data['Note'] ?? '',
      createdAt: data['createdAt'] ?? '',
      patent_name: data['patent_name'] ?? '',
    );
  }
}
