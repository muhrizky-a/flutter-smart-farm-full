// ignore_for_file: non_constant_identifier_names

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class APIService {
  const APIService();

  final String API_BASE_URL = "http://35.239.128.20:5000";

  Future<http.StreamedResponse> createPOSTMultipartRequest(
    String url, {
    required String fileKey,
    required PlatformFile file,
    Map<String, String>? headers,
    Map<String, String>? body,
  }) async {
    Uri requestURL = Uri.parse(url);
    var request = http.MultipartRequest(
      'POST',
      requestURL,
    );

    if (headers != null) request.headers.addAll(headers);
    if (body != null) request.fields.addAll(body);

    // Attach the file using the key profided in fileKey
    var attachedFile = http.MultipartFile(
      fileKey,
      file.readStream!,
      file.size,
      filename: file.name,
    );
    request.files.add(attachedFile);

    // Send the request
    http.StreamedResponse response = await request.send();

    return response;
  }

  Future<http.StreamedResponse> createPOSTFormDataRequest(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? body,
  }) async {
    Uri requestURL = Uri.parse(url);
    var request = http.MultipartRequest(
      'POST',
      requestURL,
    );

    if (headers != null) request.headers.addAll(headers);
    if (body != null) request.fields.addAll(body);

    // Send the request
    http.StreamedResponse response = await request.send();

    return response;
  }

  Future<http.Response> createPOSTRequest(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    Uri requestURL = Uri.parse(url);
    http.Response response = await http.post(
      requestURL,
      headers: headers,
      body: body,
    );
    return response;
  }

  Future<http.Response> createGETRequest(
    String url, {
    Map<String, String>? headers,
  }) async {
    Uri requestURL = Uri.parse(url);
    http.Response response = await http.get(
      requestURL,
      headers: headers,
    );

    return response;
  }

  Future<http.Response> createPUTRequest(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    Uri requestURL = Uri.parse(url);
    http.Response response = await http.put(
      requestURL,
      headers: headers,
      body: body,
    );
    return response;
  }

  Future<http.Response> createDELETERequest(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    Uri requestURL = Uri.parse(url);
    http.Response response = await http.delete(
      requestURL,
      headers: headers,
      body: body,
    );
    return response;
  }
}
