import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences sharedPreferences;

  static void init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    @required String key,
    @required dynamic value,
  }) async {
    if (value is String)
      return await sharedPreferences.setString(key, value);
    else if (value is bool)
      return await sharedPreferences.setBool(key, value);
    else if (value is int)
      return await sharedPreferences.setInt(key, value);
    else
      return sharedPreferences.setDouble(key, value);
  }

  static dynamic getData({@required key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeData({@required String key}) async {
    return sharedPreferences.remove(key);
  }
}
