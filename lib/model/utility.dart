import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  static void saveImageToPreferences(File value, double angle) async {
    List<int> imageBytes = value.readAsBytesSync();
    String base64 = base64Encode(imageBytes);
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('image_key');
    preferences.remove('angle');
    preferences.setString('image_key', base64);
    preferences.setDouble('angle', angle);
    print(preferences.getString('image_key'));
    print(preferences.getDouble('angle').toString());
  }

  static Future<String?> getImageFromPreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('IMG_KEY');
  }

  static void saveDetails(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    prefs.setString(key, value);
  }

  static Future<String?> getDetails(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
