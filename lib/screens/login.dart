import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login4/screens/homepage.dart';
import 'package:login4/screens/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: size.height*0.90,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: -250, child: Image.asset("images/lgbg2.jpg"), width: 450),
            Column(
              children: [
                SizedBox(
                  height: 400,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.5)),
                        hintStyle: TextStyle(color: Colors.white60),
                        hintText: "UserEmail",
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.mail, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 2.5)),
                        hintStyle: TextStyle(color: Colors.white60),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                      ),
                    ),
                  ),
                ),
        SizedBox(height: 40),
        SizedBox(
          width: 200,
          child: RawMaterialButton(
              //fillColor: const Color(0xFF0069FE),
fillColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              onPressed: () async {
                await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
                if(FirebaseAuth.instance.currentUser != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                } else {
                  print('invalid creds');
                }
              },
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              )),
        ),

        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have any account?', style: TextStyle(color: Colors.white),),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SignUpScreen();
                  }));
                },

                child: const Text('Sign Up'),
              ),],
          ),
        )

              ],
            ),
          ],
        ),
      ),
    );
  }
}
