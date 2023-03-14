import 'dart:async';
import 'dart:convert';

import 'package:escort/userinfo_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'firebase_realtimedb.dart';

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  var location = await Geolocator.getCurrentPosition();

  Geolocator.getPositionStream(
      locationSettings: LocationSettings(distanceFilter: 100));

  return location;
}

Future<List<Location>> getLocationFromAddress(String address) async {
  List<Location> locations = await locationFromAddress(address);
  return locations;
}

void locationfunc(userid, address) async {
  await _determinePosition();

  var safezone = await getLocationFromAddress(address);
  var latitude = safezone[0].latitude;
  var longitude = safezone[0].longitude;

  var uId = await FirebaseAuth.instance.currentUser?.uid;
  var isSafe = await RealtimeDatabase.read(uId: uId as String);

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 1,
  );

  StreamSubscription<Position> positionStream =
      Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position? position) {
    RealtimeDatabase.updateLatLng(
        uId: uId, latitude: position!.latitude, longitude: position.longitude);

    if (Geolocator.distanceBetween(
                latitude, longitude, position.latitude, position.longitude) >=
            100.0 &&
        isSafe == true) {
      RealtimeDatabase.updateSafe(uId: uId);
      onLocationChanged(position);
    }

    print(position);
    // do what you want to do with the position here
  });
}

void onLocationChanged(Position position) {
  // 위치가 변경된 경우, 처리할 작업을 여기에 추가하세요.
  print('위치가 변경되었습니다. $position');
}

class MainDementia extends StatefulWidget {
  MainDementia({super.key});

  @override
  State<MainDementia> createState() => _MainDementiaState();
}

class _MainDementiaState extends State<MainDementia> {
  final UserInfoController userinfoController = Get.put(UserInfoController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      'dementia': userinfoController.dementia.toString(),
      'email': userinfoController.email.toString(),
      'password': userinfoController.password.toString(),
      'name': userinfoController.name.toString(),
      'birth': userinfoController.birth.toString(),
      'phoneNumber': userinfoController.phoneNumber.toString(),
      'characteristics': userinfoController.characteristics.toString(),
      'blood': userinfoController.blood.toString(),
      'regidence': userinfoController.regidence.toString(),
      'place': userinfoController.place.toString(),
      'safezone': userinfoController.safezone.toString(),
    };

    String json = jsonEncode(data);
    var _qrCodeData = json;
    print(_qrCodeData);

    // QR 코드로 표시 할 데이터

    locationfunc(userinfoController.email.toString(),
        userinfoController.safezone.toString());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SizedBox(
                width: 220,
                height: 20,
                child: Text(
                  "Escort",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 47.0),
                child: IconButton(
                    onPressed: () => {}, icon: Icon(Icons.notifications)),
              )
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          bottomOpacity: 0.0,
          titleSpacing: 20,
          leadingWidth: 20,
          centerTitle: false,
          leading: Transform.translate(
            offset: Offset(10, 0),
            child: Image.asset("assets/logo.png"),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              top: 12, left: 12.0, right: 12.0, bottom: 5),
          child: Column(
            children: [
              Container(
                height: 310,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Color.fromRGBO(32, 92, 73, 89),
                ),
                child: Column(
                  children: const [
                    SizedBox(
                      child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: SizedBox(
                          width: 375,
                          height: 190,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50, // Image radius
                            backgroundImage: NetworkImage('imageUrl'),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Jenny Kim",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "010 2170 9514",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: Colors.black12),
                        width: 350,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, right: 160, bottom: 30),
                                child: Text(
                                  'Characteristics',
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Color.fromRGBO(16, 64, 59, 100),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "● A mole under the nose",
                                style: TextStyle(
                                  color: Color.fromRGBO(16, 64, 59, 100),
                                ),
                              ),
                              Text(
                                "● Big ears and smalls lips",
                                style: TextStyle(
                                  color: Color.fromRGBO(16, 64, 59, 100),
                                ),
                              ),
                              Text(
                                "● Reacting to the name 'Frank",
                                style: TextStyle(
                                  color: Color.fromRGBO(16, 64, 59, 100),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: 370,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: Colors.black12),
                        child: const Center(
                            child: Text(
                          'Item 2',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: 370,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Colors.black12,
                        ),
                        child: const Center(
                            child: Text(
                          'Item 3',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: 370,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: Colors.black12),
                        child: const Center(
                            child: Text(
                          'Item 4',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.black12),
                  child: Column(
                    children: const [
                      SizedBox(
                        child: SizedBox(
                          width: 375,
                          height: 100,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50, // Image radius
                              backgroundImage: NetworkImage('imageUrl'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                    color: Colors.black12),
                width: 350,
                height: 32,
                child: Text("asdasdasd",
                    style: TextStyle(
                      color: Color.fromRGBO(16, 64, 59, 100),
                    )),
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Container(
                      width: 250,
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          QrImage(
                            data: _qrCodeData,
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                );
                // Add your onPressed code here!
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: SizedBox(
                child: Image.asset(
                  "assets/floatbutton.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
