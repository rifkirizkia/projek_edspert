import 'dart:convert';

import 'package:projek_edspert/models/data_by_user_email.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static String userData = "data_user";

  Future<SharedPreferences> sharedPref() {
    final sharedPref = SharedPreferences.getInstance();
    return sharedPref;
  }

  Future _saveString(key, data) async {
    final _pref = await sharedPref();
    await _pref.setString(key, data);
  }

  Future<String?> _getString(key) async {
    final _pref = await sharedPref();
    return _pref.getString(key);
  }

  setUserData(DataUserByEmail data) async {
    final json = data.toJson();
    final userDataString = jsonEncode(json);
    await _saveString(userData, userDataString);
  }

  Future<DataUserByEmail?> getUserData() async {
    final user = await _getString(userData);
    final jsonUserData = jsonDecode(user!);
    final userDataModel = DataUserByEmail.fromJson(jsonUserData);
    return userDataModel;
  }
}
