import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_page.dart';
import 'root_page.dart';
import 'signup_page.dart';
import 'constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/signin.png',
                  height: 150,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Sign in to continue',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  prefixIcon: Icon(Icons.alternate_email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Constants.primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Constants.primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  try {
                    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (userCredential.user != null) {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: const HomePage(),
                          type: PageTransitionType.bottomToTop,
                        ),
                      );
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                },
                child: const Center(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('OR'),
                  ),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _handleGoogleSignIn,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Constants.primaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Image.asset('assets/images/google.png'),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Sign In with Google',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const SignUp(),
                      type: PageTransitionType.bottomToTop,
                    ),
                  );
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'New to Modern Heaven? ',
                          style: TextStyle(
                            color: Constants.blackColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Register',
                          style: TextStyle(
                            color: Constants.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleGoogleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          Navigator.pushReplacement(
            context,
            PageTransition(
              child: const RootPage(),
              type: PageTransitionType.bottomToTop,
            ),
          );
        }
      }
    } catch (error) {
      print(error);
    }
  }
}
