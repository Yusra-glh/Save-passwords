

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:objectid/objectid.dart';
import 'package:save_password/models/icons_list.dart';
import 'package:save_password/services/accounts_services.dart';
import 'dart:developer';
import '../models/account.dart';

class AccountProvider with ChangeNotifier{
  String? accountTitle;
  AccountsServices service=AccountsServices();
  List<Account> accounts=[];

 setAccount(String value){
   accountTitle=value;
   notifyListeners();
 }

  String getIcon(String value){
    for(var item in accountIcons.keys){
      if(value.toLowerCase()==item){
        return accountIcons[item]!;
      }
    }
    return 'assets/icons/key.png';
  }
Future<bool> addNewAccount(Account data) async {
   var id=ObjectId();
   data.id=id.hexString;
  final _user=await FirebaseAuth.instance.currentUser;
  log(_user.toString());
  if(_user!=null) {
    await FirebaseFirestore.instance.collection("users").doc(_user.uid).collection("accounts").doc(data.id).set(data.toJson()).whenComplete(() => log("done"));
    return true;
  }
  return false;
}
Future<List<Account>> getAccounts() async {
   final data =await service.getAccounts();
  for(var acc in data){
    var index=accounts.indexWhere((element) => element.id==acc.id);
    if(index==-1) {
      accounts.add(Account.fromJson(acc.data()));
      notifyListeners();
    }
  }

  return accounts;
}

}