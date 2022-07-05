import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bp_track/models/models.dart';
import 'dart:async';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var date = DateTime.now();

  Stream<Iterable<BloodPressure>> streamWeighIns(String id) {
    return _db
        .collection('bps')
        .where("uid", isEqualTo: id)
        .snapshots()
        .map((event) => event.docs.map((e) => BloodPressure.fromMap(e.data())));
  }

  Future<void> addWeighIn(String id, int systolic, int diastolic) {
    return _db
        .collection('bps')
        .doc()
        .set({"uid": id, "date": DateTime.now(), "systolic": systolic, 'diastolic': diastolic});
  }

  Stream<Preferences> streamPreferences(String id) {
    return _db
        .collection('preferences')
        .doc(id)
        .snapshots()
        .map((snap) => Preferences.fromMap(snap.data()!));
  }

  Future<void> updatePreferences(String id, Preferences preferences) {
    return _db
        .collection('preferences')
        .doc(id)
        .set(Preferences.toMap(preferences));
  }
}
