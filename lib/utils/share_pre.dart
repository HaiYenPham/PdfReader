import 'dart:convert';

import 'package:pdf_reader/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  getConfig(key) async {
    final prefs = await SharedPreferences.getInstance();
    String config = prefs.getString(key);
    if (config != null) {
      return ConFig.fromJson(json.decode(config));
    }
    return ConFig();
  }

  setConfig(key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  // remove(String key) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.remove(key);
  // }

  setList(key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  Future<List<String>> getList(key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }
}
