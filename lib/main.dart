import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_2/firebase_options.dart';
import 'package:project_2/signin_page.dart';
import 'home_page.dart';
import 'onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context, snapshot){
      if(snapshot.hasData){
        return HomePage();
      } else{
        return OnboardingScreen();
      }
         },
    ),
    );
  }
}