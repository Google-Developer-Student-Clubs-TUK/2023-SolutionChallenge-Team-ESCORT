import 'dart:async';

import 'package:escort/firebase_realtimedb.dart';
import 'package:escort/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_realtimedb.dart';

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

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Map<String, dynamic> _markers = {};
  List<Marker> markers = [];

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DementiaLocationTracker dementiaTracking = DementiaLocationTracker();
    RealtimeDatabase.locations().then((value) => {
          setState(() {
            _markers = value;
            _markers.forEach((key, value) {
              double longitude = value['longitude'];
              double latitude = value['latitude'];
              markers.add(
                Marker(
                  markerId: MarkerId(key),
                  position: LatLng(latitude, longitude),
                ),
              );
            });
          })
        });

    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        markers: Set<Marker>.of(markers),
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
