import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String?> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return null;
  } catch (e) {
    return e.toString();
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return true;
  } on FirebaseException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> addCoin(String id, String weight) async {
  try {
    var value = double.parse(weight);
    CollectionReference documentReference =
        FirebaseFirestore.instance.collection('users');
    documentReference.add({
      'weight': value,
      'type': id,
      'timestamp': FieldValue.serverTimestamp(),
    });
  } catch (e) {
    print(e.toString());
    return false;
  }
  return false;
}

Future<bool> deleteWeight(String uid) async {
  try {
    CollectionReference documentReference =
        FirebaseFirestore.instance.collection('users');
    documentReference.doc(uid).delete();
  } catch (e) {
    print(e.toString());
  }

  return false;
}

Future<bool> updateWeight(String uid, String type, String weight) async {
  try {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    print(uid);
    print(weight);
    users.doc(uid).update({
      'type': type,
      'weight': double.parse(weight),
      'timestamp': FieldValue.serverTimestamp(),
    });
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
