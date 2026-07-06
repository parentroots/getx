import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getx_template/data/models/user_model.dart';
import 'package:getx_template/utils/constants/storage_keys.dart';

class SharedPreferencesService {
  SharedPreferencesService._(this._preferences);

  static late final SharedPreferencesService instance;
  final SharedPreferences _preferences;

  static Future<void> init() async {
    instance = SharedPreferencesService._(
      await SharedPreferences.getInstance(),
    );
  }

  String? getString(String key) => _preferences.getString(key);
  bool? getBool(String key) => _preferences.getBool(key);
  int? getInt(String key) => _preferences.getInt(key);
  double? getDouble(String key) => _preferences.getDouble(key);

  Future<bool> setString(String key, String value) =>
      _preferences.setString(key, value);
  Future<bool> setBool(String key, bool value) =>
      _preferences.setBool(key, value);
  Future<bool> setInt(String key, int value) => _preferences.setInt(key, value);
  Future<bool> setDouble(String key, double value) =>
      _preferences.setDouble(key, value);
  Future<bool> remove(String key) => _preferences.remove(key);
  Future<bool> clear() => _preferences.clear();

  // Save any model to local storage by converting it to a JSON String
  Future<bool> saveModel<T>(
    String key,
    T model,
    Map<String, dynamic> Function(T) toJson,
  ) async {
    try {
      final String jsonStr = jsonEncode(toJson(model));
      return await setString(key, jsonStr);
    } catch (e) {
      debugPrint('Error saving model for key $key: $e');
      return false;
    }
  }

  // Get any model from local storage by deserializing the stored JSON String
  T? getModel<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final String? jsonStr = getString(key);
    if (jsonStr == null || jsonStr.isEmpty) return null;
    try {
      final Map<String, dynamic> jsonMap =
          jsonDecode(jsonStr) as Map<String, dynamic>;
      return fromJson(jsonMap);
    } catch (e) {
      debugPrint('Error loading model for key $key: $e');
      return null;
    }
  }

  // User Specific Storage Helpers
  Future<bool> saveUser(UserModel user) {
    return saveModel<UserModel>(StorageKeys.user, user, (u) => u.toJson());
  }

  UserModel? getUser() {
    return getModel<UserModel>(StorageKeys.user, UserModel.fromJson);
  }

  Future<bool> clearUser() {
    return remove(StorageKeys.user);
  }

  bool get isLoggedIn => getUser() != null;
}
