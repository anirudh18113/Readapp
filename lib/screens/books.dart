import 'package:flutter/material.dart';
import 'package:login4/models/book.dart';
import 'bookDetails.dart';
import 'package:login4/clients/bookClient.dart';

class Books extends StatefulWidget {
  final String? genreName;
  const Books({this.genreName});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  @override
  late BookClient bookClient;
  @override
  void initState() {
    bookClient = BookClient();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
            child: Text(
          'Books on ${widget.genreName}',
          style:
              TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w500,color: Colors.white),
        )),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Book>>(
              future: bookClient.getGenreBooks(widget.genreName!),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BookDetails(book: book)));
                          },
                        ),
                      );
                    },
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
}
