import 'package:http/http.dart' as http;

import 'base/api_service.dart';

class FarmMonitoringService extends APIService {
  Future<http.Response> getData() async {
    try {
      http.Response response = await super.createGETRequest(
        "${super.API_BASE_URL}/monitoring",
        // headers: {
        //   "Access-Control-Allow-Origin": "*",
        //   'Content-Type': 'application/json',
        //   'Accept': '*/*'
        // },
      );

      print(response.statusCode);
      print(response.body);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
