// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';

import 'package:envision6mdi/models/mdi/organization_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../locator.dart';
import '../models/mdi/user_model.dart';
import '../models/response/envision_response_model.dart';
import 'api_constants.dart';
import 'api_service.dart';
import 'user_preferences.dart';

enum Status {
  notLoggedIn,
  notRegistered,
  loggedIn,
  registered,
  authenticating,
  registering,
  loggedOut
}

class AuthenticationService with ChangeNotifier {
  Status _loggedInStatus = Status.notLoggedIn;
  Status get loggedInStatus => _loggedInStatus;
  final _api = locator<ApiService>();

  Future login(String uid, String password) async {
    _loggedInStatus = Status.authenticating;
    final creds = {'UserName': uid, 'UserPwd': password};
    User user = User();

    var value = await _api.post(ApiConstants.login, creds);
    print('login: $value');
    EnvisionResponseModel response = EnvisionResponseModel.fromJson(value);
    if (response.acknowledgementCode == 'AA') {
      if (response.user_1 != null) {
        user = User.fromJson(response.user_1[0]);
        if (user.userFName == null
            // && user.userPwd != password
            ) return null;
      } else {
        return null;
      }
    }
    return user;
  }

  Future<List<Organization>> getOrganizationSelectView() async {
    List<Organization> data = [];
    late EnvisionResponseModel response;
    var value = await _api.post(ApiConstants.selectOrganizationView, '');
    response = EnvisionResponseModel.fromJson(value);
    if (response.acknowledgementCode == 'AA') {
      // var result = response.organization_1;
      if (response.organization_1 != null) {
        for (var e in response.organization_1) {
          data.add(Organization.fromJson(e));
        }
      }
      // data = Organization.fromJson(result);
    }

    notifyListeners();
    return data;
  }

  setLoginFromHis(User response) {
    UserPreferences().saveUser(response);
    _loggedInStatus = Status.loggedIn;
  }

  Future<User> getMockUser() async {
    EnvisionResponseModel response = EnvisionResponseModel();
    User user = User();
    await rootBundle.loadString('data/USER_DATA.json').then(
      (value) {
        if (value != null && value != " " && value != "") {
          response = EnvisionResponseModel.fromJson(json.decode(value));
          user = User.fromJson(response.data_1[0]);
          UserPreferences().saveUser(user);
          _loggedInStatus = Status.loggedIn;
          notifyListeners();
        }
      },
    );
    return user;
  }

  Future logOut() async {
    _loggedInStatus = Status.notLoggedIn;
    UserPreferences().removeUser();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // SessionStorageHelper.clearAll();
  }
}
