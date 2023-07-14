import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:login4/models/user.dart';
import 'package:login4/screens/login.dart';
import 'package:login4/clients/userClient.dart';
import 'package:login4/screens/homepage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  late UserClient userClient;

  @override
  void initState() {
    userClient = UserClient();
    userClient.getFavouriteBooks('RA9n9IShPFQcrYY6PZZdeOI6Q993');
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(height: 50,),
          Positioned(
              top: 40, child: Image.asset("images/sgbg6.jpg"), width: 600,),
          SizedBox(height: 100,),

          Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            SizedBox(height: 350),
            Text(
              "",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 350 ,child: buildUserField(emailController, 'User Email', Icon(Icons.mail, color: Colors.white))),
            SizedBox(height: 10),
            SizedBox(
  width: 350,            child: buildUserField(
                  passwordController, 'Input Password', Icon(Icons.lock_clock, color: Colors.white), isSecure: true),
            ),
            SizedBox(height: 10,),
            SizedBox( width: 350,
              child: buildUserField(
                  firstNameController, 'First Name', Icon(Icons.person_add, color: Colors.white,)),
            ),
            SizedBox(
   width: 350,           child: buildUserField(lastNameController, 'Last Name',
                  Icon(Icons.person_add_alt_1, color: Colors.white)),
            ),
            SizedBox(height: 50,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Center(
                child: SizedBox(
                  width: 200,
                  child: RawMaterialButton(

                      fillColor: Colors.green,
                      elevation: 0.0,
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      onPressed: () async {
                        final userCredential = await firebase_auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        final userUid = userCredential.user!.uid;
                        User _user = User(
                          uid: userUid,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          favouriteBooks: [],
                        );
                        await userClient.addUser(_user);
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }));
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      )),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have any account?', style: TextStyle(color: Colors.white),),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      }));
                      // Get.(LoginScreen());
                    },
                    child: Text('Login In'),
                  ),
                ],
              ),
            )
          ],
        ),],
      ),
    );
    ;
  }

  TextField buildUserField(
      TextEditingController controller, String hintText, Icon prefixIcon,
      {bool isSecure = false}) {
    return TextField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      obscureText: isSecure,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.white, width: 1.5)),
        hintText: hintText, hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: prefixIcon,
      ),
    );
  }
}
