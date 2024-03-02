import 'package:flutter_dotenv/flutter_dotenv.dart';

mixin EnvUtils {
  String getEnvValue(String env) {
    String variable = dotenv.get(env, fallback: '');
    return variable;
  }
}
