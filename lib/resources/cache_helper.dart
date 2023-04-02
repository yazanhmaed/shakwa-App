import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  // static late SharedPreferences sharedPreferences;
  // ignore: prefer_typing_uninitialized_variables
  static var sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future setFav(List<String> fav) async {
    return await sharedPreferences.setStringList('fav', fav);
  }

  static List<String> getFav() {
    return sharedPreferences.getStringList('fav');
  }

  static Future<bool> seveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is List?) {
      return await sharedPreferences.setStringList(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}