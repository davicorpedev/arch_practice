import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_api/error/exceptions.dart';

abstract class ApiRequester {
  Future performPostRequest({
    required String path,
    required Map<String, dynamic> body,
  });
}

class HttpApiRequester implements ApiRequester {
  final http.Client _client;
  final String _serverUrl;
  final String _apiKey;
  final String _serverVersion;

  HttpApiRequester({
    required http.Client client,
    required String serverUrl,
    required String apiKey,
    required String serverVersion,
  })  : _client = client,
        _serverUrl = serverUrl,
        _apiKey = apiKey,
        _serverVersion = serverVersion;

  @override
  Future performPostRequest({
    required String path,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await _buildPostRequest(
        path: path,
        body: body,
      );

      if (response.statusCode == 200) {
        return _decodeResponse(body: response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  Future<http.Response> _buildPostRequest({
    required String path,
    required Map<String, dynamic> body,
  }) async {
    final url = Uri.https(
      _serverUrl,
      '$_serverVersion/$path',
    );

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_apiKey"
    };

    return await _client.post(
      url,
      headers: headers,
      body: json.encode(body),
    );
  }

  dynamic _decodeResponse({required String body}) {
    final decodedResponse = json.decode(body);

    return decodedResponse['data'];
  }
}
