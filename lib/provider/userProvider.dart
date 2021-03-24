import 'package:bossbus/model/user.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserProvider with ChangeNotifier {
  UserModel _user = UserModel();

  void signUpWithEmail(String id, String password, String phoneNumber,
      String firstName, String email) {
    _user.id = id;
    _user.email = email.trim();
    _user.password = password.trim();
    _user.phoneNumber = phoneNumber.trim();
    _user.firstName = firstName.trim();
    _user.accountCreated = Timestamp.now();
    notifyListeners();
  }
}
