import 'dart:convert';
import 'package:http/http.dart' as http;

class TestClient extends http.BaseClient {
  http.Response? getResponse;
  http.Response? postResponse;
  http.Response? putResponse;
  http.Response? deleteResponse;

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    if (getResponse == null) throw StateError('No getResponse configured');
    return getResponse!;
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    if (postResponse == null) throw StateError('No postResponse configured');
    return postResponse!;
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    if (putResponse == null) throw StateError('No putResponse configured');
    return putResponse!;
  }

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    if (deleteResponse == null) throw StateError('No deleteResponse configured');
    return deleteResponse!;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw UnimplementedError();
  }
}
