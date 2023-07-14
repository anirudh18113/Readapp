import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login4/screens/books.dart';
import 'package:login4/widgets/search_bar.dart';
import 'package:login4/clients/userClient.dart';

import '../models/book.dart';
import 'bookDetails.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> genreNames = [
    'fiction',
    'comedy',
    'romance',
    'drama',
    'science',
    'computers',
  ];
  List<String> imageList= [
    'images/fiction.jpg',
    'images/comedy.jpg',
    'images/romance.jpg',
    'images/drama.jpg',
    'images/science.jpg',
    'images/tech.jpg',



  ];

  late UserClient userClient;
  late String userId;

  @override
  void initState() {
    userClient = UserClient();
    userId = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
        centerTitle: true,
        title: RichText(
          text: const TextSpan(children: [
            TextSpan(
              text: "R E A D. ",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: "L Y ",
              style: TextStyle(
                color: Color(0xFFFFFFDF),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
      ),
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const SearchBar(),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              crossAxisSpacing: 7,
              mainAxisSpacing: 10,
              children: [
                for (String genreName in genreNames)
                  buildGenreContainer(genreName,context,imageList)
              ],
            ),
            SizedBox(height: 90),
            Container(height: 30,child: RichText(
            text: const TextSpan(children: [
            TextSpan(
              text: " FAVOURITE COLLECTION",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
      ),),
            SizedBox(height: 10,),
            Container(
              height: 200,
                child: buildFavs()
            ),

          ],
        ),
      ),
    );
  }

  Container buildGenreContainer(String genreName,BuildContext context,List<String> imagelist) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image : AssetImage(imageList[genreNames.indexOf(genreName)]), fit: BoxFit.cover,) ,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 40),
            blurRadius: 50,
            color: Color(0xFFD3D3D9).withOpacity(.84),
          )
          
        ],
        color: Color(0xFFD3D3D9),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(8),
      child: GestureDetector(

        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Books(genreName: genreName);
          })).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }

  FutureBuilder buildFavs () {
    return FutureBuilder<List<Book>>(
      future: userClient.getFavouriteBooks(userId),
      builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: List.generate(snapshot.data!.length, (index) {
              var book = snapshot.data![index];
              return Container(

                width: 200, // Adjust the width as needed
                child: Card(

                  child: InkWell(
customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(500)),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return BookDetails(book: book);

                      })).then((value) {
                        setState(() {});
                      });
                    },
                    child: Image.network(

                      book.thumbnailUrl!,
                       // Adjust the fit property as needed
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }),
          );
        } else {
          return const Text('Empty data', style: TextStyle(color: Colors.white));
        }
      },
    );
  }
}
