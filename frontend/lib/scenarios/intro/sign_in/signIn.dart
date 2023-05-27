import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../../supports/userinfo_controller.dart';
import '../../dementia/main_dementia.dart';
import '../../dementia/main_partner_navigation.dart';
import '../reset/reset_password.dart';

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

updateDeviceToken(deviceToken, uid) async {
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var request = http.Request(
      'PUT',
      Uri.parse(
          'http://34.22.87.100:8080/api/v1/ppConnection/deviceToken/$uid'));
  request.bodyFields = {'deviceToken': deviceToken};
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  print(await response.stream.bytesToString());
}

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final UserInfoController userinfocontroller = Get.put(UserInfoController());

  Future<void> firebaseLogin(id, password, BuildContext context) async {
    print("logintest");
    print(id);
    print(password);

    try {
      await FirebaseMessaging.instance.requestPermission();
      FirebaseMessaging messaging = FirebaseMessaging.instance;

// use the returned token to send messages to users from your custom server
      String? token = await messaging.getToken(
        vapidKey:
            "BP1gjwgxChmDU-HeUCXx_UNaamYPQgJhouArF_VDwkw_6z3z4BmzoyIwlZSKOLX9IRofiTn3UQPj4mJnOFsbTpA",
      );

      print("token ! ! !");
      print(token);

      print(id);
      print(password);

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

          print(documentSnapshot.data());

          print("navigation test");

          final data = documentSnapshot.data() as Map<String, dynamic>;

          userinfocontroller.setEmail(data['emailAddress']);
          userinfocontroller.setPassword(data['password']);
          userinfocontroller.setName(data['name']);
          userinfocontroller.setBirth(data['birth']);
          userinfocontroller.setPhoneNumber(data['phoneNumber']);
          userinfocontroller.setDementia(data['dementia']);
          userinfocontroller.setCharacteristics(data['characteristics']);
          userinfocontroller.setBlood(data['blood']);
          userinfocontroller.setRegidence(data['regidence']);
          userinfocontroller.setPlace(data['place']);
          userinfocontroller.setSafezone(data['safezone']);

          await updateDeviceToken(token, user.uid);

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

  bool _obscureText = true;

  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String id = '';
    String password = '';

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 260, top: 20, bottom: 25),
                child: Text("Sign In".tr,
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 110),
                child: Text("Please enter Your ID and Password".tr),
              ),
              Container(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 325, bottom: 20),
                child: Text(
                  "ID".tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: idController,
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
                  onChanged: (value) => {
                    setState(() {
                      id = value;
                      print(id);
                    })
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 275, bottom: 20, top: 30),
                child: Text(
                  "Password".tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Color.fromRGBO(16, 64, 59, 10),
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
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
                  onChanged: (value) => {
                    setState(() {
                      password = value;
                      print(password);
                    })
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 170.0,
                ),
                child: TextButton(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPassword()))
                  },
                  child: Text(
                    "Forgot password? Click here".tr,
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () => {
                firebaseLogin(
                    idController.text, passwordController.text, context)
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                backgroundColor: Color.fromRGBO(16, 64, 59, 10),
                fixedSize: const Size(250.0, 40.0),
              ),
              child: Text("Continue".tr),
            ),
          ),
        ));
  }
}
