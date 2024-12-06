import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AutheService {
  // firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //function to handle user signup

  Future<String?> signup({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      //create user in firebase authentication with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      // save additonal user data in firestore(name , role email)
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name.trim(),
        'email': email.trim(),
        'role': role // role determines if user is admin or user
      });
      return null; // success :no erorr messages
    } catch (e) {
      return e.toString(); // error : return the exception message
    }
  }

  // function to handle user login

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      //create signin user in firebase authentication with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      // fetching the user role from firestore to determinde access level
       DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      
      return userDoc['role']; // return the users role(admin/user)
      // success :no erorr messages
    } catch (e) {
      return e.toString(); // error : return the exception message
    }
  }
  signOut () async {
    _auth.signOut();
  }
}
