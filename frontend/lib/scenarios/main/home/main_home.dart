// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart' as lottie;

import '../../firebase/firebase_realtimedb.dart';

class User {
  String? id;
  String? name;
  double? latitude;
  double? longitude;

  User({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

class DementiaLocationTracker {
  final DatabaseReference _databaseRef = FirebaseDatabase(
          databaseURL:
              'https://escort-8572e-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref();

  // 1. Firebase Realtime Database에서 치매노인 위치 정보 읽기
  getLocationStream() {
    return _databaseRef.child('users').onValue;
  }

  // 2. 보호자가 선택한 치매노인들의 위치 정보 필터링
  getFilteredLocationStream(List<String> selectedIds) {
    return getLocationStream().map((event) {
      final locations = Map<String, dynamic>.from(event.snapshot.value);
      final filteredLocations = locations.entries
          .where((entry) => selectedIds.contains(entry.key))
          .map((entry) => MapEntry(entry.key, entry.value))
          .toList();
      return {'users': Map.fromEntries(filteredLocations)};
    });
  }

  // 3. 필터링된 치매노인들의 위치 정보 실시간 업데이트
  void trackSelectedDementiaLocations(List<String> selectedIds,
      Function(Map<String, dynamic> locations) onUpdate) {
    getFilteredLocationStream(selectedIds).listen((event) {
      final locations =
          Map<String, dynamic>.from(event.snapshot.value['users']);
      onUpdate(locations);
    });
  }
}

void dementiaSos(dementiauid) async {
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var request =
      http.Request('POST', Uri.parse('http://34.22.87.100:8080/api/v1/sos'));
  request.bodyFields = {'protegeUId': dementiauid};
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  if (response.statusCode == 201) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

void dementiaCloth(dementiauid, cloth) async {
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var request = http.Request(
      'PUT', Uri.parse('http://34.22.87.100:8080/api/v1/protege/$dementiauid'));
  request.bodyFields = {'clothing': cloth};
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

void cancleSos(dementauid) async {
  var request = http.Request('DELETE',
      Uri.parse('http://34.22.87.100:8080/api/v1/protege/$dementauid'));
  request.bodyFields = {};

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

class MapSample extends StatefulWidget {
  const MapSample({
    Key? key,
  }) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> with TickerProviderStateMixin {
  List<Map<String, dynamic>> _markers = [{}];
  List<Marker> markers = [];
  Map<String, dynamic> protegeList = {};
  var currentLocation = LatLng(0, 0); // 현재 위치

  List<LatLng> dangerProteges = [];

  var cloth;

  var safeLight = false;
  var currLocation;
  late final AnimationController _animationController;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  getDementia() async {
    var uId = await FirebaseAuth.instance.currentUser?.uid;

    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'http://34.22.87.100:8080/api/v1/ppConnection/protector/$uId'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("success");

      Map<String, dynamic> data =
          json.decode(await response.stream.bytesToString());
      setState(() {
        protegeList = data;
      });
      RealtimeDatabase.locations(protegeList).then((value) => {
            setState(() {
              _markers = value;

              _markers.map((element) async {
                double longitude = (element['longitude']);
                double latitude = (element['latitude']);

                BitmapDescriptor safeMarker =
                    await BitmapDescriptor.fromAssetImage(
                  ImageConfiguration(size: Size(48, 48)),
                  'assets/safemarker.png',
                );

                BitmapDescriptor dangerMarker =
                    await BitmapDescriptor.fromAssetImage(
                  ImageConfiguration(size: Size(48, 48)),
                  'assets/dangermarker.png',
                );

                bool isSafe = element['isSafe'];

                setState(() {
                  if (isSafe == false) {
                    safeLight = true;

                    if (latitude != Null && longitude != Null) {
                      dangerProteges.add(LatLng(latitude, longitude));
                    }
                  }
                });

                print(element);

                markers.add(Marker(
                    markerId: MarkerId(element['uid']),
                    position: LatLng(latitude, longitude),
                    onTap: () => {
                          element['isSafe']
                              ? showModalBottomSheet(
                                  isScrollControlled: true,
                                  barrierColor: Colors.white.withOpacity(0),
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(35.0),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.004,
                                                  color: Color.fromRGBO(
                                                      207, 204, 212, 1)),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      64, 75, 99, 0.04),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              width: double.infinity,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.23,
                                              margin: EdgeInsets.all(16.0),
                                              child: Row(children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            20)), // 20 is the radius
                                                  ),
                                                  padding: EdgeInsets.all(20),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.18,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              20)), // 20 is the radius
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      child: Image.network(
                                                        element['imageUrl'],
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  child: Column(children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 50.0),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                element['name'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            7.0),
                                                                child:
                                                                    Image.asset(
                                                                  "assets/safemarker2.png",
                                                                  width: 18,
                                                                  height: 18,
                                                                ),
                                                              )
                                                            ]),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15.0),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                        child: Text(
                                                          element['safeZones']
                                                              [0],
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      59,
                                                                      59,
                                                                      59,
                                                                      1)),
                                                          textAlign:
                                                              TextAlign.left,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ]),
                                            )
                                          ],
                                        ));
                                  },
                                )
                              : showModalBottomSheet(
                                  isScrollControlled: true,
                                  barrierColor: Colors.white.withOpacity(0),
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(35.0),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.35,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.004,
                                                  color: Color.fromRGBO(
                                                      207, 204, 212, 1)),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      64, 75, 99, 0.04),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              width: double.infinity,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.16,
                                              margin: EdgeInsets.all(16.0),
                                              child: Row(children: [
                                                Container(
                                                  padding: EdgeInsets.all(20),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.4,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    child: Image.network(
                                                      element['imageUrl'],
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Column(children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 27.0),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center, // Add this

                                                            children: [
                                                              Text(
                                                                element['name'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            7.0),
                                                                child:
                                                                    Image.asset(
                                                                  "assets/rounddangermarker2.png",
                                                                  width: 18,
                                                                  height: 18,
                                                                ),
                                                              )
                                                            ]),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.65,
                                                        child: Text(
                                                          element['safeZones']
                                                              [0],
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                          textAlign:
                                                              TextAlign.left,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ]),
                                            ),
                                            Container(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.08,
                                                      child: ElevatedButton(
                                                        onPressed: () => {
                                                          Navigator.pop(
                                                              context), // 바텀 시트를 닫습니다.
                                                          cancleSos(
                                                              element['uid'])
                                                        },
                                                        child: Text(
                                                          "Not Danger",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      16,
                                                                      64,
                                                                      59,
                                                                      1)),
                                                        ),
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateColor
                                                                  .resolveWith(
                                                            (states) =>
                                                                Color.fromRGBO(
                                                                    232,
                                                                    233,
                                                                    235,
                                                                    1),
                                                          ),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 30.0),
                                                      child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateColor
                                                                    .resolveWith(
                                                              (states) => Color
                                                                  .fromRGBO(
                                                                      16,
                                                                      64,
                                                                      59,
                                                                      1),
                                                            ),
                                                            shape: MaterialStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            18.0),
                                                              ),
                                                            ),
                                                          ),
                                                          onPressed: () => {
                                                                Navigator.pop(
                                                                    context),
                                                                showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  barrierColor:
                                                                      Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0),
                                                                  context:
                                                                      context,
                                                                  shape:
                                                                      const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              35.0),
                                                                    ),
                                                                  ),
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom: MediaQuery.of(context)
                                                                              .viewInsets
                                                                              .bottom),
                                                                      child: Container(
                                                                          width: MediaQuery.of(context).size.width,
                                                                          height: MediaQuery.of(context).size.height * 0.35,
                                                                          child: Column(children: [
                                                                            Center(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(top: 10.0),
                                                                                child: Container(width: MediaQuery.of(context).size.width * 0.08, height: MediaQuery.of(context).size.height * 0.004, color: Color.fromRGBO(207, 204, 212, 1)),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 20, right: 225.0),
                                                                              child: Text(
                                                                                "Description",
                                                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 25.0),
                                                                              child: Text(
                                                                                "If you know what he's wearing today, please write it",
                                                                                style: TextStyle(fontSize: 12.5),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 20,
                                                                            ),
                                                                            Center(
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width * 0.9,
                                                                                height: MediaQuery.of(context).size.height * 0.07,
                                                                                child: TextFormField(
                                                                                  style: TextStyle(color: Colors.black),
                                                                                  decoration: InputDecoration(
                                                                                    filled: true,
                                                                                    fillColor: Colors.black12,
                                                                                    border: OutlineInputBorder(
                                                                                      borderRadius: BorderRadius.circular(20.0),
                                                                                      borderSide: BorderSide(
                                                                                        width: 0,
                                                                                        style: BorderStyle.none,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  onChanged: (value) => {
                                                                                    setState(() {
                                                                                      cloth = value;
                                                                                    })
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 20,
                                                                            ),
                                                                            Center(
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width * 0.9,
                                                                                height: MediaQuery.of(context).size.height * 0.07,
                                                                                child: ElevatedButton(
                                                                                  onPressed: () => {
                                                                                    dementiaSos(element['uid']),
                                                                                    dementiaCloth(element['uid'], cloth),
                                                                                    Navigator.pop(context),
                                                                                    showDialog<void>(
                                                                                      //다이얼로그 위젯 소환
                                                                                      context: context,
                                                                                      barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
                                                                                      builder: (BuildContext context) {
                                                                                        return AlertDialog(
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.all(
                                                                                              Radius.circular(30.0),
                                                                                            ),
                                                                                          ),
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
                                                                                                      Image.asset("assets/calling.png"),
                                                                                                      SizedBox(
                                                                                                        height: 30,
                                                                                                      ),
                                                                                                      Text('Successful in calling', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                                                                                      Center(
                                                                                                        child: Text('for Help', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        height: 30,
                                                                                                      ),
                                                                                                      Center(child: Text('Escorteres can now locate the')),
                                                                                                      Center(child: Text('patient')),
                                                                                                      SizedBox(
                                                                                                        height: 30,
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        width: MediaQuery.of(context).size.width * 0.6,
                                                                                                        height: MediaQuery.of(context).size.height * 0.08,
                                                                                                        child: ElevatedButton(
                                                                                                          style: ElevatedButton.styleFrom(
                                                                                                            primary: Color(0xCC10403B),
                                                                                                            shape: RoundedRectangleBorder(
                                                                                                              borderRadius: BorderRadius.circular(30.0),
                                                                                                            ),
                                                                                                          ),
                                                                                                          onPressed: () {
                                                                                                            Navigator.pop(context);
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
                                                                                  child: Text("Continue"),
                                                                                  style: ButtonStyle(
                                                                                    backgroundColor: MaterialStateColor.resolveWith(
                                                                                      (states) => Color.fromRGBO(16, 64, 59, 1),
                                                                                    ),
                                                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                      RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(20.0),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ])),
                                                                    );
                                                                  },
                                                                ),
                                                              },
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.3,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.08,
                                                            child: Center(
                                                                child: Text(
                                                                    "Ask For Help")),
                                                          )),
                                                    )
                                                  ]),
                                            )
                                          ],
                                        ));
                                  },
                                )
                        },
                    icon: isSafe ? safeMarker : dangerMarker));
              }).toList();
            })
          });
    } else {
      print(response.reasonPhrase);
    }
  }

  void getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    currLocation = await Geolocator.getCurrentPosition();

    setState(() {
      currLocation;
    });
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currLocation.latitude, currLocation.longitude),
          zoom: 15,
        ),
      ),
    );

    print(currLocation);
  }

  void getDangerLocation(currentLocation) async {
    LocationPermission permission = await Geolocator.requestPermission();

    currLocation = currentLocation;
    setState(() {
      currLocation;
    });

    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currLocation.latitude, currLocation.longitude),
          zoom: 15,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getDementia();
    getCurrentLocation();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DementiaLocationTracker dementiaTracking = DementiaLocationTracker();

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            onPressed: () {
              getCurrentLocation();
            },
            child: Icon(Icons.my_location_outlined),
          ),
          SizedBox(height: 16),
          Stack(
            children: <Widget>[
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: OverflowBox(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                    child: safeLight
                        ? lottie.Lottie.asset(
                            'assets/lottie/104817-red-wave.json',
                          )
                        : Container(),
                  )),
              FloatingActionButton(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onPressed: () {
                  print(dangerProteges);
                  setState(() {
                    // 현재 위치가 마지막 위치이면 처음 위치로 돌아감
                    currentLocation = (currentLocation == dangerProteges.last)
                        ? dangerProteges.first
                        : dangerProteges[
                            dangerProteges.indexOf(currentLocation) + 1];
                    getDangerLocation(currentLocation); // 위치 업데이트
                  });
                },
                child: Image.asset("assets/warning.png"),
              ),
            ],
          ), // 두 번째 FAB와 간격을 둡니다.
        ],
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          myLocationButtonEnabled: false,
          markers: Set<Marker>.of(markers),
          mapType: MapType.terrain,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          initialCameraPosition: currLocation != null
              ? CameraPosition(
                  target: LatLng(currLocation.latitude, currLocation.longitude))
              : CameraPosition(target: LatLng(37.7749, -122.4194), zoom: 14),
        ),
        Positioned(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.07,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Image.asset("assets/maincircleicon.png",
                    width: MediaQuery.of(context).size.width / 5),
                SizedBox(width: MediaQuery.of(context).size.width / 90),
                Text("Clairo"),
                SizedBox(width: MediaQuery.of(context).size.width * 0.43),
                Image.asset("assets/sort.png",
                    width: MediaQuery.of(context).size.width * 0.1),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
