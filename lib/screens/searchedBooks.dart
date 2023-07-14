import 'package:flutter/material.dart';
import 'package:login4/clients/bookClient.dart';
import 'package:login4/models/book.dart';
import 'package:login4/screens/bookDetails.dart';

class SearchedBooks extends StatefulWidget {
  final String bookName;
  const SearchedBooks({super.key, required this.bookName});

  @override
  State<SearchedBooks> createState() => _SearchedBooksState();
}

class _SearchedBooksState extends State<SearchedBooks> {
  late BookClient client;

  @override
  void initState() {
    client = BookClient();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
            child: Text(
              'Search results for ${widget.bookName}',
              style:
              TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
            )),
      ),
      body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<Book>>(
                  future: client.getSearchedBooks(widget.bookName),
                  builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      print('-----------------------------');
                      print(snapshot.data!.length);
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var book = snapshot.data![index];
                            return Card(
                              child: ListTile(
                                title: Text(book.title),
                                subtitle: Text(book.author),
                                leading: Image.network(book.thumbnailUrl!),
                                onTap: () {
                                  _openDetailPage(context, book);
                                },
                              ),
                            );
                          }
                      );
                    } else {
                      return const Text('Empty data');
                    }
                  },
                ),
              )
            ],
          )),
    );
  }

  _openDetailPage(context, Book book) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BookDetails(book: book)));
  }
}
