import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import "package:os_detect/os_detect.dart" as platform;

void setFCMData(
  FirebaseFirestore db,
  FirebaseMessaging fcm,
  User user,
) async {
  String? fcmToken = await fcm.getToken();

  if (fcmToken != null) {
    var tokenRef = db.collection('tokens').doc(user.uid);
    tokenRef.set({
      'created': FieldValue.serverTimestamp(),
      'platform': platform.operatingSystem,
      'token': fcmToken
    });
  }
}

void updateUserData(FirebaseFirestore db, User user) async {
  DocumentReference ref = db.collection('users').doc(user.uid);

  return ref.set({
    'uid': user.uid,
    'email': user.email,
    'displayName': user.displayName,
    'lastSeen': DateTime.now()
  });
}

bool isNumeric(String? num) {
  if (num == null) {
    return false;
  }

  return double.tryParse(num) != null;
}

bool isInt(String? num) {
  if (num == null) {
    return false;
  }

  return int.tryParse(num) != null;
}

String? checkInValidator(String? value) {
  if (value == null || value.isEmpty || !isNumeric(value)) {
    return 'Please enter a measurement';
  }
  return null;
}