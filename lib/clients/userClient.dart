import 'dart:async';
import 'dart:convert' as convert;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login4/models/user.dart';
import 'package:login4/models/book.dart';
import 'package:http/http.dart' as http;

class UserClient {
  late FirebaseFirestore _firestore;
  UserClient() {
    _firestore = FirebaseFirestore.instance;
  }
  Future<void> addUser(User user) async{
    final userCollection = _firestore.collection('users');
    await userCollection.doc(user.uid).set(user.toFirestore());
  }

  Future<void> updateUserFav (String bookId, String userId) async {
    final userRef = _firestore.collection('users').doc(userId);
    final userDoc = await userRef.get();

    if (userDoc.exists) {
      final List<String> currentFavourites = List<String>.from(userDoc.data()!['favouriteBooks'] ?? []);
      currentFavourites.add(bookId);
      await userRef.update({'favouriteBooks': currentFavourites});
    } else {
      throw Exception('User not found');
    }
  }
  Future<List<Book>> getFavouriteBooks(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    final data = doc.data();
    if (data != null && data.containsKey('favouriteBooks')) {
      final favBooks = List<String>.from(data['favouriteBooks'] ?? []);
      List<Book> bookList = [];
      for (dynamic bookId in favBooks) {
        var url = 'https://www.googleapis.com/books/v1/volumes/$bookId';
        var response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10), onTimeout: () {
          throw TimeoutException('Unable to establish connection. Please try again after some time.');
        });
        if (response.statusCode == 200) {
          bookList.addAll(_parseBookJson(response.body));
        }
      }
      return bookList;
    }
    return [];
  }

  List<Book> _parseBookJson(String jsonStr) {
    final jsonMap = convert.json.decode(jsonStr);
    final volumeInfo = jsonMap['volumeInfo'];
    Map<String, dynamic>? imageLinks = volumeInfo['imageLinks'] as Map<String, dynamic>?;
    List<dynamic>? authors = volumeInfo['authors'] as List<dynamic>?;

    return [
      Book(
        id: jsonMap['id'],
        title: volumeInfo['title'],
        author: authors != null && authors.isNotEmpty ? authors[0] : ' ',
        description: volumeInfo['description'],
        thumbnailUrl: imageLinks != null && imageLinks.containsKey('smallThumbnail')
            ? imageLinks['smallThumbnail']
            : 'https://www.flaticon.com/free-icon/not-found_2748558',
      )
    ];
  }
}