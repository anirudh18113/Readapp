import 'package:flutter/material.dart';
import 'package:login4/models/book.dart';
import 'package:login4/clients/userClient.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookDetails extends StatefulWidget {
  final Book book;
  const BookDetails({required this.book});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  late UserClient _favouriteBooksClient;
  @override
  void initState() {
    _favouriteBooksClient = UserClient();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              String userId = FirebaseAuth.instance.currentUser!.uid;
              print(widget.book.id);
              print(userId);
              _favouriteBooksClient.updateUserFav(widget.book.id, userId);
              print('Book added to the favs');
            },
            icon: Icon(Icons.heart_broken),
          )
        ],
        title: Text(
          widget.book.title,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: Image.network(widget.book.thumbnailUrl!),
                  height: 150,
                ),
                SizedBox(height: 15),
                Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Stack(children: [
                        Text(
                          'Rating:',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Text(
                            '4.5/5',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(
                        widget.book.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.book.author,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Description',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      widget.book.description == null
                          ? const Text('No description available!',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300))
                          : Text(
                              widget.book.description!,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300),
                            )
                    ]))
              ],
            ),
          ]),
        ),
      )),
    );
  }
}
