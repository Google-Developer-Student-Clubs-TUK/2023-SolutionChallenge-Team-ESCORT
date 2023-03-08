import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> firebaseAuth(
    var emailAddress,
    var password,
    var name,
    var birth,
    var phoneNumber,
    var dementia,
    var characteristics,
    var blood,
    var regidence,
    var place,
    var safezone,
    var imagePath) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(credential.user?.uid)
        .set({
      'name': name,
      'birth': birth,
      'phoneNumber': phoneNumber,
      'dementia': dementia,
      'characteristics': characteristics,
      'blood': blood,
      'regidence': regidence,
      'place': place,
      'safezone': safezone,
      'imagePath': imagePath,
      'emailAddress': emailAddress,
      'password': password,
      // Add additional user information here
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
