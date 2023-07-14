import 'package:flutter/material.dart';
import 'package:login4/screens/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(

        // width: double.infinity,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     fit: BoxFit.scaleDown,
        //
        //     opacity: 50,
        //     image: AssetImage("images/w3.jpg"),
        //     //fit: BoxFit.fill
        //   )
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              height: 500,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,

                    opacity: 50,
                    image: AssetImage("images/w3.jpg"),
                    //fit: BoxFit.fill
                  )
              ),
            ),
            SizedBox(height: 30),
            RichText(text: TextSpan(
              children: [TextSpan(text: "R E A D.",style: TextStyle(color: Colors.grey,fontSize: 50,fontWeight: FontWeight.bold)),
              TextSpan(text: "L Y ",style: TextStyle(color: Color(0xFFFFFFDF),fontSize: 50,fontWeight: FontWeight.bold))
              ]
            )

            ),
            SizedBox(height: 40),

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));

              },
              child: Container(

                padding: EdgeInsets.symmetric(vertical: 16,horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0,15),
                      blurRadius: 30,
                      color: Color(0x2666666).withOpacity(.11),
                    )
                  ]
                ),
                child: Text("start reading", style: TextStyle(fontSize: 16,color: Colors.black54),

              ),



              ),
            ),
          ],


        ),


      ),
    );
  }
}
