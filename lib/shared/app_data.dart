import 'package:flutter/material.dart';

class Appdata with ChangeNotifier {
  String userStatus = '';
  String page = '';
  int notificationCount = 0;
  late MemberProfile user;
}

class MemberProfile {
  int id = 0;
  String fullname = '';
  String phone = '';
  String image = '';
  String email = '';
  double wallet_balance = 0;
}