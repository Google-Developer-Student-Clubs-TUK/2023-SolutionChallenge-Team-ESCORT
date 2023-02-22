import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escort/main_dementia.dart';
import 'package:escort/main_partner_navigation.dart';
import 'package:escort/reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfo {
  final String imagePath;
  final String emailAddress;
  final String place;
  final String safezone;
  final String name;
  final String characteristics;
  final String birth;
  final String residence;
  final String blood;
  final String password;
  final String phoneNumber;
  final bool dementia;

  UserInfo({
    required this.imagePath,
    required this.emailAddress,
    required this.place,
    required this.safezone,
    required this.name,
    required this.characteristics,
    required this.birth,
    required this.residence,
    required this.blood,
    required this.password,
    required this.phoneNumber,
    required this.dementia,
  });

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      imagePath: map['imagePath'] ?? '',
      emailAddress: map['emailAddress'] ?? '',
      place: map['place'] ?? '',
      safezone: map['safezone'] ?? '',
      name: map['name'] ?? '',
      characteristics: map['characteristics'] ?? '',
      birth: map['birth'] ?? '',
      residence: map['residence'] ?? '',
      blood: map['blood'] ?? '',
      password: map['password'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      dementia: map['dementia'] ?? '',
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  Future<void> firebaseLogin(id, password, BuildContext context) async {
    print(id);
    print(password);

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: id, password: password)
          //아이디와 비밀번호로 로그인 시도
          .then((value) async {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          final data = documentSnapshot.data() as Map<String, dynamic>;

          print(data['dementia']);
          if (data['dementia'] == "Dementia.yes") {
            print("this is dementia page");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MainDementia()));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MainPartner()));
          }
        } else {
          print("fail");
        }

        print(value);
        return value;
      });
    } on FirebaseAuthException catch (e) {
      //로그인 예외처리
      if (e.code == 'user-not-found') {
        print('등록되지 않은 이메일입니다');
      } else if (e.code == 'wrong-password') {
        print('비밀번호가 틀렸습니다');
      } else {
        print(e.code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String id = '';
    String password = '';

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 260, top: 20, bottom: 25),
              child: Text("Sign In",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 110),
              child: Text("Please enter Your ID and Password"),
            ),
            Container(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 325, bottom: 20),
              child: Text(
                "ID",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 350,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                onChanged: (value) => {id = value},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 275, bottom: 20, top: 30),
              child: Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 350,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                onChanged: (value) => {password = value},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 170.0,
              ),
              child: TextButton(
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ResetPassword()))
                },
                child: Text(
                  "Forgot password? Click here",
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () => {firebaseLogin(id, password, context)},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                backgroundColor: Color.fromRGBO(16, 64, 59, 10),
                fixedSize: const Size(250.0, 40.0),
              ),
              child: Text("Continue"),
            ),
          ),
        ));
  }
}
