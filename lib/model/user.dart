import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String id, firstName, email, phoneNumber, password;
  Timestamp accountCreated;

  UserModel(
      {this.id,
      this.firstName,
      this.email,
      this.phoneNumber,
      this.password,
      this.accountCreated});
}
