import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exceptions/authentication_error.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../use_case/auth_use_case.dart';

class WelcomeUtils {
  static Future<bool> isWelcomed() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Object? data = sharedPreferences.getBool("welcomeStatus");
    return data != null;
  }

  static Future<void> enableWelcomeStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool("welcomeStatus", true);
  }

  static Future<void> checkUser(BuildContext context) async {
    Future.delayed(Duration.zero, () async {
      User? user = await AuthUseCase(AuthService()).getUser();

      bool isSignedIn = user != null;

      if (context.mounted) {
        if (isSignedIn) {
          try {
            await AuthUseCase(AuthService())
                .checkLogin(accessToken: user.token);
            if (context.mounted) {
              await Navigator.pushReplacementNamed(context, "/main");
            }
          } catch (e) {
            if (e is AuthenticationError) {
              Navigator.pushReplacementNamed(context, "/login");
            }
          }
        } else {
          Navigator.pushReplacementNamed(context, "/login");
        }
      }
    });
  }
}
