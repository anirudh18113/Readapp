import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? uid;
  String? firstName;
  String? lastName;
  String? email;
  List<String>? favouriteBooks;


  User({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.favouriteBooks
  });

  factory User.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return User(
        uid: snapshot.id,
        firstName: data?['firstName'],
        lastName: data?['lastName'],
        email: data?['email'],
        favouriteBooks: List.from(data?['favouriteBooks'])
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'favouriteBooks': favouriteBooks
    };
  }
}
