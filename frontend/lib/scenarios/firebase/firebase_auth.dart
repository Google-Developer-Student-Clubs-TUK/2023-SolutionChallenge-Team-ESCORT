import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

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
  var imagePath,
) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    print(credential.user);
    print("sigup logic test");
    print(dementia);

    // Firebase Messaging 초기화
    await FirebaseMessaging.instance.requestPermission();
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    // FCM 토큰 요청
    String? token = await _firebaseMessaging.getToken();
    print(token);

    if (dementia == 'Dementia.yes') {
      DatabaseReference _databaseReference = FirebaseDatabase(
              databaseURL:
                  'https://escort-8572e-default-rtdb.asia-southeast1.firebasedatabase.app')
          .ref("users/" + credential.user!.uid);
      await _databaseReference.set({'isSafe': true});
      http.MultipartRequest request = new http.MultipartRequest(
          'POST', Uri.parse("http://34.22.87.100:8080/api/v1/protege"));
      request.fields['email'] = emailAddress;
      request.fields['password'] = password;
      request.fields['name'] = name;
      request.fields['characteristic'] = characteristics;
      request.fields['bloodType'] = blood;
      request.fields['phone'] = phoneNumber;
      request.fields['safeZones'] = safezone;
      request.fields['deviceToken'] = token!;
      request.fields['uId'] = credential.user!.uid;
      request.fields['birth'] = birth;

      //요청에 이미지 파일 추가
      request.files
          .add(await http.MultipartFile.fromPath('profileImage', imagePath));

      var response = await request.send();
      print(dementia);

      print(await response.stream.bytesToString());
    } else {
      http.MultipartRequest request = new http.MultipartRequest(
          'POST', Uri.parse("http://34.22.87.100:8080/api/v1/protector"));
      request.fields['email'] = emailAddress;
      request.fields['password'] = password;
      request.fields['name'] = name;
      request.fields['phone'] = phoneNumber;
      request.fields['address'] = regidence;
      request.fields['deviceToken'] = token!;
      request.fields['safeZones'] = safezone;
      request.fields['birth'] = birth;
      request.fields['uId'] = credential.user!.uid;

      //요청에 이미지 파일 추가
      request.files
          .add(await http.MultipartFile.fromPath('profileImage', imagePath));
      var response = await request.send();
      print(dementia);
      print(await response.stream.bytesToString());
    }

    print(credential.user?.uid);

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
