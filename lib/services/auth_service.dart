import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'base/api_service.dart';

class AuthService extends APIService {
  bool isSignedIn() => true;

  void init() {
    if (isSignedIn()) {
      debugPrint("user signed in");
    } else {
      debugPrint("not signed in");
    }
  }

  Future<http.StreamedResponse> login(String email, String password) async {
    try {
      logout();

      http.StreamedResponse response = await super.createPOSTFormDataRequest(
        "${super.API_BASE_URL}/login",

        // headers: {
        //   "Content-type": "multipart/form-data",
        //   "Access-Control-Allow-Origin": "*"
        // },
        body: {
          "email": email,
          "password": password,
        },
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      logout();
      http.Response response = await super.createPOSTRequest(
        "${super.API_BASE_URL}/register",
        headers: {
          "accept": "application/json",
        },
        body: {
          "name": name,
          "email": email,
          "password": password,
        },
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getUserFromLocal() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString("localUser");
    if (data == null) return null;

    return User.fromJson(jsonDecode(data));
  }

  Future<void> saveUser(Map<String, dynamic> data) async {
    User user = User.fromJson({
      "id": data["id"],
      "name": data["name"],
      "username": data["username"],
      "picture_path": data["picture_path"],
      "picture_link": data["picture_link"],
      "role": {
        "id": data["role"]["id"],
        "name": data["role"]["role_name"],
      },
      "token": data["token"],
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("localUser", jsonEncode(user.toJson()));
  }

  // Future<http.Response> geUserById(int id,
  //     {required String accessToken}) async {
  //   try {
  //     http.Response response = await super.createGETRequest(
  //       "${super.API_BASE_URL}/user/$id",
  //       headers: {
  //         "Authorization": "Bearer $accessToken",
  //         "accept": "application/json",
  //       },
  //     );

  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<http.Response> checkLogin({required String accessToken}) async {
    try {
      // http.Response response = await super.createGETRequest(
      //   "${super.API_BASE_URL}/checkLogin",
      //   headers: {
      //     "Authorization": "Bearer $accessToken",
      //     "accept": "application/json",
      //   },
      // );
      http.Response response = http.Response("", 200);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> updateDisplayName(String? displayName) async {
  //   await firebaseAuth.currentUser!.updateDisplayName(displayName);
  // }

  // Future<void> updatePhoto(String photoURL) async {
  //   await firebaseAuth.currentUser!.updatePhotoURL(photoURL);
  // }

  void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove("localUser");
  }
}
