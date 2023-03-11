import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

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

class RealtimeDatabase {
  static void write({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      DatabaseReference _databaseReference =
          FirebaseDatabase.instance.ref("users");

      await _databaseReference.set(data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> read({required String userId}) async {
    try {
      DatabaseReference _databaseReference =
          FirebaseDatabase.instance.ref("users/userid1");
      final snapshot = await _databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> _snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        return _snapshotValue['name'] ?? '';
      } else {
        return '';
      }
    } catch (e) {
      rethrow;
    }
  }
}

void read() async {
  DatabaseReference _databaseReference =
      FirebaseDatabase().reference().child("users").child("userid1");
  final snapshot = await _databaseReference.get();
  if (snapshot.exists) {
    print(snapshot.value);
  } else {
    print('No data available.');
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Map<String, Marker> _markers = {};

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    read();
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
