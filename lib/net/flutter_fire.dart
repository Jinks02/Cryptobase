import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password); // sign In existing user
    return true;
  } catch (e) {
    log(e.toString());
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password); // create new user
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      log('the password is too weak');
    } else if (e.code == 'email-already-in-use') {
      log('account already exists');
    }
    return false;
  } catch (e) {
    log(e.toString());
    return false;
  }
}

Future<bool> addCoin(String id, String amount) async {
  try {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    var value = double.parse(amount);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        // means suppose user is adding bitcoin, but he initially does not have any doc for bitcoin
        documentReference.set({'Amount': value});
        return true;
      }

      double newAmount = snapshot['Amount'] + value;
      transaction.update(documentReference, {'Amount': newAmount});
      return true;
    });
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> deleteCoins(String id) async {
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('Coins')
      .doc(id)
      .delete();
  return true;
}
