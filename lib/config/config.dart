import 'dart:convert';

import 'package:flutter/services.dart';

class ConfigUration{
  static Future<Map<String, dynamic>> getConfig() {
    return rootBundle.loadString('assets/config/config.json').then(
      (value){
        return jsonDecode(value) as Map<String, dynamic>;
      }
    );
  }
}