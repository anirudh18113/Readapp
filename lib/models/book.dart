import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String? thumbnailUrl;
  final String? description;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.thumbnailUrl,
    this.description
  });

  // factory Book.fromFirestore(
  //     DocumentSnapshot<Map<String, dynamic>> snapshot,
  //     SnapshotOptions? options,
  //     ) {
  //   final data = snapshot.data();
  //   return Book(
  //     id: data?['id'],
  //     title: data?['title'],
  //     author: data?['author'],
  //     thumbnailUrl: data?['thumbnailUrl'],
  //    description: data?['description']
  //   );
  // }
  //
  // Map<String, dynamic> toFirestore() {
  //   return {
  //     'title': title,
  //     'author': author,
  //     'thumbnailUrl': thumbnailUrl,
  //     'description': description
  //   };
  // }
}
