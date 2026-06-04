import 'dart:convert';

import 'package:college_management/core/constants/app_apis.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/Authentication/models/user_model.dart';

class AuthShareprefHelper {

  // =========================
  // KEYS
  // =========================

  static  String _userKey = AppApis.userKey;
  static  String _tokenKey = AppApis.tokenKey;

  // =========================
  // SAVE USER
  // =========================

  static Future<bool> saveUser(UserModel user) async {

    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    String userJson = jsonEncode(
      user.toJson(),
    );

    return await prefs.setString(
      _userKey,
      userJson,
    );
  }

  // =========================
  // GET USER
  // =========================

  static Future<UserModel?> getUser() async {

    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    String? userData =
    prefs.getString(_userKey);

    if (userData == null) {
      return null;
    }

    Map<String, dynamic> decoded =
    jsonDecode(userData);

    return UserModel.fromJson(decoded);
  }

  // =========================
  // REMOVE USER
  // =========================

  static Future<bool> removeUser() async {

    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    return await prefs.remove(_userKey);
  }

  // =========================
  // SAVE TOKEN
  // =========================

  static Future<bool> saveToken(
      String token) async {

    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    return await prefs.setString(
      _tokenKey,
      token,
    );
  }

  // =========================
  // GET TOKEN
  // =========================

  static Future<String?> getToken() async {

    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    return prefs.getString(_tokenKey);
  }

  // =========================
  // REMOVE TOKEN
  // =========================

  static Future<bool> removeToken() async {

    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    return await prefs.remove(_tokenKey);
  }

  // =========================
  // CLEAR ALL AUTH DATA
  // =========================

  static Future<void> clearAuthData() async {

    final SharedPreferences prefs =
    await SharedPreferences.getInstance();

    await prefs.remove(_userKey);
    await prefs.remove(_tokenKey);
  }
}