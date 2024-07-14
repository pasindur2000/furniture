import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../root_page.dart';
import '../services/firestore_services.dart';
import '../constants.dart';

class AuthServices {
  static Future<void> signupUser(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirestoreServices.saveUser(name, email, userCredential.user!.uid);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful')));
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const RootPage(),
          type: PageTransitionType.bottomToTop,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email Provided already Exists')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? 'Registration Failed')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static Future<void> signinUser(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You are Logged in')));
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const RootPage(),
          type: PageTransitionType.bottomToTop,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user Found with this Email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password did not match')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? 'Sign in Failed')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static Future<void> handleGoogleSignIn(BuildContext context) async {
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
        await FirebaseAuth.instance.signInWithCredential(credential);
        if (userCredential.user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Google Sign In Successful')));
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
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google Sign In Failed: $error')));
    }
  }
}
