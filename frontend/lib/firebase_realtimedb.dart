import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabase {
  static DatabaseReference _databaseReference = FirebaseDatabase(
          databaseURL:
              'https://escort-8572e-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref();
  static void write({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
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
    await _databaseReference
        .child("users/$uId")
        .update({"latitude": latitude, "longitude": longitude});
  }

  static void updateSafe({
    required String uId,
  }) async {
    await _databaseReference.child("users/$uId").update({"isSafe": false});
  }

  static Future<bool> read({required String uId}) async {
    try {
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

  static Future<Map<String, dynamic>> locations() async {
    try {
      _databaseReference.child("users/");
      final snapshot = await _databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> _snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        print(_snapshotValue['users']);
        return _snapshotValue;
      } else {
        return {};
      }
    } catch (e) {
      rethrow;
    }
  }
}
