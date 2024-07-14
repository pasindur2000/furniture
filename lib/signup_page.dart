import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_2/signin_page.dart';
import 'root_page.dart';
import 'constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String name = '';

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
                  'assets/images/signup.png',
                  height: 150,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Join Us!',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Create your account',
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
                  name = value;
                },
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Enter Full Name',
                  prefixIcon: Icon(Icons.person),
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
                    final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (newUser != null) {
                      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: const RootPage(), // Replace with your home page widget
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
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text('OR'),
                  ),
                  const Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 20),
              Container(
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
                      'Sign Up with Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const SignIn(),
                      type: PageTransitionType.bottomToTop,
                    ),
                  );
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Have an Account? ',
                          style: TextStyle(
                            color: Constants.blackColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Login',
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
}
