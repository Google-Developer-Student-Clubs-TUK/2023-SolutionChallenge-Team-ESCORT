import 'dart:async';
import 'dart:convert';

import 'package:escort/firebase_realtimedb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

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
      http.Request('POST', Uri.parse('http://34.22.70.120:8080/api/v1/sos'));
  request.bodyFields = {'protegeUId': dementiauid};
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  if (response.statusCode == 201) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

void cancleSos(dementauid) async {
  var request = http.Request('DELETE',
      Uri.parse('http://34.22.70.120:8080/api/v1/protege/$dementauid'));
  request.bodyFields = {};

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  List<Map<String, dynamic>> _markers = [{}];
  List<Marker> markers = [];
  Map<String, dynamic> protegeList = {};
  var currentLocation = LatLng(0, 0);

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  getDementia() async {
    var uId = await FirebaseAuth.instance.currentUser?.uid;

    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'http://34.22.70.120:8080/api/v1/ppConnection/protector/$uId'));

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
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.002,
                                              color: Colors.grey,
                                              margin: EdgeInsets.all(20.0),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black12,
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
                                                  padding: EdgeInsets.all(50),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.4,
                                                  child: Container(
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
                                                      0.6,
                                                  child: Column(children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
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
                                                                  fontSize: 25),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          40.0),
                                                              child: Image.asset(
                                                                  "assets/safemarker.png"),
                                                            )
                                                          ]),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20.0),
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
                                                              fontSize: 20),
                                                          textAlign:
                                                              TextAlign.left,
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
                                                0.3,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.002,
                                              color: Colors.grey,
                                              margin: EdgeInsets.all(20.0),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black12,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              width: double.infinity,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                              margin: EdgeInsets.all(16.0),
                                              child: Row(children: [
                                                Container(
                                                  padding: EdgeInsets.all(20),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.4,
                                                  child: Container(
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
                                                      0.6,
                                                  child: Column(children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
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
                                                                  fontSize: 25),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          40.0),
                                                              child: Image.asset(
                                                                  "assets/rounddangermarker.png"),
                                                            )
                                                          ]),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 0.0),
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
                                                              fontSize: 20),
                                                          textAlign:
                                                              TextAlign.left,
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
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                    .black12),
                                                        onPressed: () => {
                                                              Navigator.pop(
                                                                  context), // 바텀 시트를 닫습니다.
                                                              cancleSos(element[
                                                                  'uid'])
                                                            },
                                                        child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                            child: Image.asset(
                                                                "assets/xvector.png"))),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 30.0),
                                                      child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary:
                                                                Color.fromRGBO(
                                                                    16,
                                                                    64,
                                                                    59,
                                                                    10),
                                                          ),
                                                          onPressed: () => {
                                                                dementiaSos(
                                                                    element[
                                                                        'uid'])
                                                              },
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.57,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05,
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

  @override
  void initState() {
    super.initState();
    getDementia();
  }

  @override
  Widget build(BuildContext context) {
    Location location = Location();

    DementiaLocationTracker dementiaTracking = DementiaLocationTracker();

    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        markers: Set<Marker>.of(markers),
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) async {
          final currentLocation = await Geolocator.getCurrentPosition();

          print(currentLocation);

          controller.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(currentLocation.latitude!, currentLocation.longitude!),
              15.0));
        },
      ),
    );
  }
}
