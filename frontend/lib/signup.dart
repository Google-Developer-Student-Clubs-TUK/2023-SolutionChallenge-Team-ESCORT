// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'firebase_auth.dart';
import 'auth_controller.dart';

enum Dementia { yes, no }

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class SignUp2 extends StatefulWidget {
  final Dementia dementia;

  const SignUp2({
    Key? key,
    required this.dementia,
  }) : super(key: key);

  @override
  State<SignUp2> createState() => _SignUpState2();
}

class SignUp3 extends StatefulWidget {
  const SignUp3({
    super.key,
  });

  @override
  State<SignUp3> createState() => _SignUpState3();
}

class SignUp4 extends StatefulWidget {
  const SignUp4({
    super.key,
  });

  @override
  State<SignUp4> createState() => _SignUpState4();
}

class SignUp5 extends StatefulWidget {
  const SignUp5({
    super.key,
  });

  @override
  State<SignUp5> createState() => _SignUpState5();
}

class SignUp6 extends StatefulWidget {
  const SignUp6({
    super.key,
  });

  @override
  State<SignUp6> createState() => _SignUpState6();
}

class _SignUpState extends State<SignUp> {
  Dementia _dementia = Dementia.yes;
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: 220,
            height: 15,
            child: FAProgressBar(
              currentValue: 20,
              progressColor: Color.fromRGBO(16, 64, 59, 10),
              backgroundColor: Color.fromRGBO(16, 64, 59, 180),
            ),
          ),
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
              padding: const EdgeInsets.only(right: 20, top: 20, bottom: 25),
              child: Text("Do you have Dementia?",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text("This information is necessary to use our service."),
            ),
            Container(
              height: 60,
            ),
            RadioListTile(
                activeColor: Color.fromRGBO(16, 64, 59, 10),
                title: Text("Yes, But I'm good"),
                value: Dementia.yes,
                groupValue: _dementia,
                onChanged: (value) {
                  setState(() {
                    authController.setDementia(value.toString());
                    print(authController.dementia);

                    _dementia = value!;
                  });
                }),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child:
                  Container(height: 1.0, width: 500.0, color: Colors.black12),
            ),
            RadioListTile(
                activeColor: Color.fromRGBO(16, 64, 59, 10),
                title: Text("No, I'm good"),
                value: Dementia.no,
                groupValue: _dementia,
                onChanged: (value) {
                  setState(() {
                    authController.setDementia(value.toString());
                    print(authController.dementia);
                    _dementia = value!;
                  });
                })
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp2(dementia: _dementia),
                    ))
              },
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

class _SignUpState2 extends State<SignUp2> {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: 220,
            height: 15,
            child: FAProgressBar(
              currentValue: 40,
              progressColor: Color.fromRGBO(16, 64, 59, 10),
              backgroundColor: Color.fromRGBO(16, 64, 59, 180),
            ),
          ),
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
              padding: const EdgeInsets.only(right: 175, top: 20, bottom: 25),
              child: Text("Who are you?",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 75),
              child: Text("Tell us about yourself. You can change it"),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 200),
              child: Text("later on the MyPage."),
            ),
            Container(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 300, bottom: 20),
              child: Text(
                "Name",
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
                onChanged: (text) {
                  setState(() {
                    authController.setName(text);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 255, bottom: 20, top: 20),
              child: Text(
                "Date of birth",
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
                onChanged: (text) {
                  setState(() {
                    authController.setBirth(text);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 240, bottom: 20, top: 20),
              child: Text(
                "Phone Number",
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
                onChanged: (text) {
                  setState(() {
                    authController.setPhoneNumber(text);
                  });
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp3()))
              },
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

class _SignUpState3 extends State<SignUp3> {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: 220,
            height: 15,
            child: FAProgressBar(
              currentValue: 60,
              progressColor: Color.fromRGBO(16, 64, 59, 10),
              backgroundColor: Color.fromRGBO(16, 64, 59, 180),
            ),
          ),
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
              padding: const EdgeInsets.only(right: 80, top: 20, bottom: 25),
              child: Text("Create Your Account",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 75),
              child: Text("Enter your E-mail address and password"),
            ),
            Container(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 240, bottom: 20),
              child: Text(
                "E-mail Address",
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
                onChanged: (text) {
                  setState(() {
                    authController.setEmail(text);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 270, bottom: 20, top: 20),
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
                onChanged: (text) {
                  setState(() {
                    authController.setPassword(text);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 210, bottom: 20, top: 20),
              child: Text(
                "Confirm Password",
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
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp4()))
              },
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

class _SignUpState4 extends State<SignUp4> {
  final AuthController authController = Get.put(AuthController());

  var _pickedFile;
  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 4;

    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: 220,
            height: 15,
            child: FAProgressBar(
              currentValue: 80,
              progressColor: Color.fromRGBO(16, 64, 59, 10),
              backgroundColor: Color.fromRGBO(16, 64, 59, 180),
            ),
          ),
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
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 100, top: 20, bottom: 25, left: 15),
                child: Text("Give Us More Detail About You!",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Text("The information is necessary to use our"),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 290),
                child: Text("service."),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 270, top: 15),
                child: Text(
                  "Your Image",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (_pickedFile == null)
                Container(
                    constraints: BoxConstraints(
                      minHeight: imageSize,
                      minWidth: imageSize,
                    ),
                    child: GestureDetector(
                        onTap: () {
                          _showBottomSheet();
                        },
                        child: Stack(
                          children: [
                            Image.asset(
                              "assets/profileimage.png",
                              width: imageSize,
                              height: imageSize,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 70, top: 70),
                              child: Image.asset(
                                "assets/imageplus.png",
                                width: 30,
                                height: 30,
                              ),
                            )
                          ],
                        )))
              else
                Center(
                  child: Container(
                    width: imageSize,
                    height: imageSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: FileImage(_pickedFile), fit: BoxFit.cover),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70, top: 65),
                      child: Image.asset(
                        "assets/imageplus.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              Container(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 235, bottom: 20),
                child: Text(
                  "Characteristics",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 350,
                height: 45,
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
                  onChanged: (value) =>
                      {authController.setCharacteristics(value)},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 265, bottom: 20, top: 20),
                child: Text(
                  "Blood Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 350,
                height: 45,
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
                  onChanged: (value) => {authController.setBlood(value)},
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp5()))
              },
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

  _showBottomSheet() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => _getCameraImage(),
              child: const Text('카메라촬영'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _getPhotoLibraryImage(),
              child: const Text('앨범'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }

  _getCameraImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = File(pickedFile.path);
        print(_pickedFile);

        authController.saveImage(File(pickedFile.path));
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }

  _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print("pickedfile!!");
    print(pickedFile);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = File(pickedFile.path);
        print(_pickedFile);

        authController.saveImage(File(pickedFile.path));
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }
}

class _SignUpState5 extends State<SignUp5> {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: 220,
            height: 15,
            child: FAProgressBar(
              currentValue: 100,
              progressColor: Color.fromRGBO(16, 64, 59, 10),
              backgroundColor: Color.fromRGBO(16, 64, 59, 180),
            ),
          ),
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
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 100, top: 20, bottom: 25, left: 15),
                child: Text("Give Us More Detail About You!",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Text("The information is necessary to use our"),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 290),
                child: Text("service."),
              ),
              Container(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 270, bottom: 20),
                child: Text(
                  "Regidence",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 350,
                height: 45,
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
                  onChanged: (value) => {authController.setRegidence(value)},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 210, bottom: 20, top: 20),
                child: Text(
                  "Your Favorite Place",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 350,
                height: 45,
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
                  onChanged: (value) => {authController.setPlace(value)},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 270, bottom: 20, top: 20),
                child: Text(
                  "Safe Zone",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 350,
                height: 45,
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
                  onChanged: (value) => {authController.setSafezone(value)},
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () => {
                firebaseAuth(
                  authController.email.toString(),
                  authController.password.toString(),
                  authController.name.toString(),
                  authController.birth.toString(),
                  authController.phoneNumber.toString(),
                  authController.dementia.toString(),
                  authController.characteristics.toString(),
                  authController.blood.toString(),
                  authController.regidence.toString(),
                  authController.place.toString(),
                  authController.safezone.toString(),
                  authController.imagePath.toString(),
                ),
                showDialog<void>(
                  //다이얼로그 위젯 소환
                  context: context,
                  barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: ListBody(
                          //List Body를 기준으로 Text 설정
                          children: <Widget>[
                            Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Image.asset("assets/signupmark.png"),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Text('Sign Up Successful!',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text('Your account has been created'),
                                  Text('Let\'s begin!'),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xCC10403B),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Go to Home'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              },
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

class _SignUpState6 extends State<SignUp6> {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Text("helloworld")),
    );
  }
}
