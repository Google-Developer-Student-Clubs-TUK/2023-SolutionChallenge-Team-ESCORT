import 'dart:async';
import 'dart:convert';

import 'package:escort/dementia.dart';
import 'package:escort/main_dementia_controller.dart';
import 'package:escort/main_dementia_qr.dart';
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
  final DementiaController dementiaController = Get.put(DementiaController());

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

    dementiaController.disconnectAndNewConnection(
        FirebaseAuth.instance.currentUser?.uid ?? "-");

    dementiaController.loadDementia();
    dementiaController.loadPartner();

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
        body: Obx(
          () {
            DementiaInfo? dementiaInfo = dementiaController.dementiainfo.value;
            PartnerInfo? partnerInfo = dementiaController.partnerInfo.value;

            if (dementiaInfo != null && partnerInfo != null) {
              return buildDementia(
                dementiaInfo,
                partnerInfo,
                dementiaController.isSafe.value,
                dementiaController.isShowCall,
                () {
                  dementiaController.clickCall(partnerInfo.phone);
                },
              );
            } else {
              return Text('Loading...');
            }
          },
        ),
        floatingActionButton: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: FloatingActionButton(
              onPressed: () {
                Get.to(
                  MainDementiaQr(),
                  arguments: [
                    dementiaController.dementiainfo.value?.name ?? "-",
                    FirebaseAuth.instance.currentUser?.uid ?? "-",
                  ],
                );
                // Add your onPressed code here!
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Image.asset(
                "assets/floatbutton.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
