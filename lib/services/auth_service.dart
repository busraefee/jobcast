import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jobjob/feature/login/view/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobjob/feature/login/view/login_view.dart';

class Authentication {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> mailSignIn(
      {required String mail, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: mail, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
    }
    return user;
  }

  Future<User?> createPerson(String name, String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore
        .collection("Person")
        .doc(user.user!.uid)
        .set({'userName': name, 'email': email});

    return user.user;
  }

  Future<User?> signUp(
      {required String mail,
      required String password,
      String? passagain,
      String? name}) async {
    User? user;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "barry.allen@example.com",
              password: "SuperSecretPassword!");
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        print(e.message.toString());
      }
    }
    return user;
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> googleSignOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<FirebaseApp> initializeFirebase(
      {required BuildContext context}) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeView(
                user: user,
              )));
    }
    return firebaseApp;
  }

  Future<FirebaseApp> initializeSignUp({required BuildContext context}) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginView()));
    }
    return firebaseApp;
  }
}
