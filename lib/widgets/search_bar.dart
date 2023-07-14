import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login4/screens/searchedBooks.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String bookName = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        onChanged: (value) {
          bookName = value;
        },
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchedBooks(bookName: bookName);
                }));
              },
              child: Icon(
                Icons.search_rounded,
                color: Colors.green[300],
              ),
            ),
            hintText: 'Search Books by name',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.green.shade300,
                ),
                borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green.shade300),
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
