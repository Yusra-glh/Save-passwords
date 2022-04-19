import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AccountsServices{
  static get collection => null;

   Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAccounts() async {
    final _user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(_user!.uid)
        .collection("accounts")
        .get();
    return data.docs;
  }

  static getUser(String id) async {
    final snapshot = await collection.doc(id).get();
    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }
}