import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../exceptions/authentication_error.dart';
import '../exceptions/client_error.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthUseCase {
  final AuthService _service;
  const AuthUseCase(this._service);

  Future<void> login(String email, String password) async {
    void validateInput() {
      String message = "";
      if (email.isEmpty && password.isEmpty) {
        message = "Terjadi kesalahan: Email dan Password tidak ada";
      } else {
        if (password.isEmpty) {
          message = "Terjadi kesalahan: Password tidak ada";
        }

        if (email.isEmpty) {
          message = "Terjadi kesalahan: Email tidak ada";
        }
      }

      if (message.isNotEmpty) throw ClientError(message: message);
    }

    try {
      validateInput();

      // Authenticate
      http.StreamedResponse response = await _service.login(email, password);
      String result = await response.stream.bytesToString();
      Map<String, dynamic> responseBody = jsonDecode(result);

      if (response.statusCode != 200) {
        String message =
            "Terjadi kendala saat login. Silahkan coba lagi nanti.";

        if (responseBody.containsKey("error")) {
          message = responseBody["error"];
        }

        throw ClientError(statusCode: response.statusCode, message: message);
      }

      // Get user by Id
      // http.Response userResponse = await _service.geUserById(
      //   responseBody["data"]["id"],
      //   accessToken: responseBody["data"]["token"],
      // );

      // Map<String, dynamic> userResponseBody = jsonDecode(userResponse.body);
      // if (userResponse.statusCode != 200) {
      //   String message =
      //       "Terjadi kendala saat mendapatkan data User. Silahkan coba lagi nanti.";
      //   if (userResponseBody.containsKey("message")) {
      //     message =
      //         "Terjadi kendala saat mendapatkan data User: ${userResponseBody["message"]}";
      //   }

      //   throw ClientError(
      //     statusCode: userResponse.statusCode,
      //     message: message,
      //   );
      // }

      // await _service.saveUser(
      //   {
      //     ...userResponseBody["data"],
      //     "token": responseBody["data"]["token"],
      //   },
      // );
    } catch (e) {
      print(e);
      print(e.toString());
      if (e is http.ClientException) {
        print(e.message);
        print(e.uri);

        throw http.ClientException("Koneksi internet terputus");
      }
      rethrow;
    }
  }

  Future<void> register(String name, String email, String password) async {
    void validateInput() {
      String message = "";
      if (email.isEmpty && password.isEmpty) {
        message = "Terjadi kesalahan: email dan Password tidak ada";
      } else {
        if (password.isEmpty) {
          message = "Terjadi kesalahan: Password tidak ada";
        }
        if (password.length < 8) {
          message = "Terjadi kesalahan: Password kurang dari 8 karakter";
        }
        if (email.isEmpty) {
          message = "Terjadi kesalahan: email tidak ada";
        }
      }

      if (message.isNotEmpty) throw ClientError(message: message);
    }

    try {
      validateInput();
      http.Response response = await _service.register(name, email, password);

      if (response.statusCode != 201) {
        String message =
            "Terjadi kendala saat register. Silahkan coba lagi nanti.";

        throw ClientError(statusCode: response.statusCode, message: message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getUser() async => await _service.getUserFromLocal();

  Future<void> checkLogin({
    required String accessToken,
  }) async {
    http.Response response =
        await _service.checkLogin(accessToken: accessToken);

    if (response.statusCode != 200) {
      if (response.statusCode == 401) {
        throw AuthenticationError();
      }

      Map<String, dynamic> responseBody = jsonDecode(response.body);
      String message =
          "Terjadi kendala saat cek Login. Silahkan coba lagi nanti.";
      if (responseBody.containsKey("message")) {
        message = "Terjadi kesalahan saat login: ${responseBody["message"]}";
      }

      throw ClientError(statusCode: response.statusCode, message: message);
    }
  }

  void logout() => _service.logout();

  void saveUser(Map<String, dynamic> data) async {
    await _service.saveUser(data);
  }
}
