import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabase {
  static void write({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      DatabaseReference _databaseReference = await FirebaseDatabase(
              databaseURL:
                  'https://escort-8572e-default-rtdb.asia-southeast1.firebasedatabase.app')
          .ref();
      _databaseReference.child("users/" + userId);
      await _databaseReference.set(data);
    } catch (e) {
      rethrow;
    }
  }

  static void updateLatLng(
      {required String uId,
      required double latitude,
      required double longitude}) async {
    DatabaseReference _databaseReference = await FirebaseDatabase(
            databaseURL:
                'https://escort-8572e-default-rtdb.asia-southeast1.firebasedatabase.app')
        .ref();
    await _databaseReference
        .child("users/$uId")
        .update({"latitude": latitude, "longitude": longitude});
  }

  static void updateSafe({
    required String uId,
  }) async {
    DatabaseReference _databaseReference = await FirebaseDatabase(
            databaseURL:
                'https://escort-8572e-default-rtdb.asia-southeast1.firebasedatabase.app')
        .ref();
    await _databaseReference.child("users/$uId").update({"isSafe": false});
  }

  static Future<bool> read({required String uId}) async {
    try {
      DatabaseReference _databaseReference = await FirebaseDatabase(
              databaseURL:
                  'https://escort-8572e-default-rtdb.asia-southeast1.firebasedatabase.app')
          .ref();
      final snapshot = await _databaseReference.child("users/$uId").get();

      if (snapshot.exists) {
        Map<String, dynamic> _snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);

        return _snapshotValue['isSafe'];
      } else {
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> locations(
      Map<String, dynamic> protegeList) async {
    try {
      //print(protegeList['result']);
      var snapshot;

      List<dynamic> data = protegeList['result'];

      List<Map<String, dynamic>> mapData = [];

      for (var element in data) {
        var uid = element['uid'];
        var imageUrl = element['imageUrl'];
        var name = element['name'];
        var safezones = element['safeZones'];

        DatabaseReference _databaseReference = await FirebaseDatabase(
                databaseURL:
                    'https://escort-8572e-default-rtdb.asia-southeast1.firebasedatabase.app')
            .ref();

        snapshot = await _databaseReference.child("users/$uid").get();
        Map<String, dynamic> _snapshotValue =
            await Map<String, dynamic>.from(snapshot.value as Map);
        _snapshotValue['uid'] = uid;
        _snapshotValue['imageUrl'] = imageUrl;
        _snapshotValue['name'] = name;
        _snapshotValue['safeZones'] = safezones;

        mapData.add(_snapshotValue);
      }

      return mapData;
      //data.map((value) => {print(value), print("hello")}).toList();

      // protegeList.forEach((key, value) {
      //   print(value);
      // });
    } catch (e) {
      rethrow;
    }
  }
}
