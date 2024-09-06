import 'package:flutter/material.dart';

class Appdata with ChangeNotifier {
  String userName = '';
  late MemberProfile user;
}

class MemberProfile {
  int id = 0;
}