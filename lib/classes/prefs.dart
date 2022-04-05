import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Future<bool> isCompleted(int idx) async {
    var map = await completedMap();
    return map[idx.toString()] == true;
  }

  setCompleted(int idx, bool c) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> map = await completedMap();
    map[idx.toString()] = c;
    prefs.setString('readed', jsonEncode(map));
  }

  Future<Map<String, dynamic>> completedMap() async {
    final prefs = await SharedPreferences.getInstance();
    var json = prefs.getString('readed');
    Map<String, dynamic> map = jsonDecode(json ?? '{}');
    return map;
  }
}
