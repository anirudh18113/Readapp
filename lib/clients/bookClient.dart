import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/book.dart';

class BookClient {

  Future<List<Book>> getGenreBooks(String genreType) async {
    var url = 'https://www.googleapis.com/books/v1/volumes?q=subject:$genreType&maxResults=40';

    var response = await http
        .get(Uri.parse(url))
        .timeout(Duration(seconds: 10), onTimeout: () {
      throw TimeoutException(
          'Unable to establish connection . Please try again after sometime');
    });
    return _parseBookJson(response.body);
  }

  Future<List<Book>> getSearchedBooks(String bookName) async {
    var url = 'https://www.googleapis.com/books/v1/volumes?q=$bookName&maxResults=20';

    var response = await http
        .get(Uri.parse(url))
        .timeout(Duration(seconds: 10), onTimeout: () {
      throw TimeoutException(
          'Unable to establish connection . Please try again after sometime');
    });

    return _parseBookJson(response.body);
  }

  List<Book> _parseBookJson(String jsonStr) {
    final jsonMap = convert.json.decode(jsonStr);
    final jsonList = jsonMap['items'] as List<dynamic>;
    if (jsonList == null) {
      return [];
    }
    return jsonList.map((jsonBook) {
      final volumeInfo = jsonBook['volumeInfo'];
      Map<String, dynamic>? imageLinks = volumeInfo['imageLinks'] as Map<String, dynamic>?;
      List<dynamic>? authors = volumeInfo['authors'] as List<dynamic>?;

      return Book(
        id: jsonBook['id'],
        title: volumeInfo['title'],
        author: authors != null && authors.isNotEmpty ? authors[0] : ' ',
        description: volumeInfo['description'],
        thumbnailUrl: imageLinks != null && imageLinks.containsKey('smallThumbnail')
            ? imageLinks['smallThumbnail']
            : 'https://www.flaticon.com/free-icon/not-found_2748558',
      );
    }).toList();
  }
}
