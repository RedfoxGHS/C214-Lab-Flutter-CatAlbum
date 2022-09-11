
import 'package:cat_album_lab_flutter/model/user_data.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<UserData> getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonUserData = prefs.getString("USER_DATA");

  if(jsonUserData == null){
    return UserData();
  }

  Map<String, dynamic> mapUser = json.decode(jsonUserData);

  UserData userData = UserData.fromJson(mapUser);
  return userData;
}

UserData initUserData() {

  return UserData();
}

void saveData(UserData userData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("USER_DATA", jsonEncode(userData.toJson()));
}