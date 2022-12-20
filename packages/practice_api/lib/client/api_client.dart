import 'package:practice_api/client/api_requester.dart';
import 'package:practice_api/client/api_result.dart';

abstract class ApiClient {
  Future<ApiResult> loadImages({required String prompt});
}

class HttpApiClient implements ApiClient {
  final ApiRequester _requester;

  HttpApiClient({required ApiRequester requester}) : _requester = requester;

  @override
  Future<ApiResult> loadImages({required String prompt}) async {
    final body = {
      "prompt": prompt,
      "n": 4,
    };

    return await _requester.performPostRequest(
      path: 'images/generations',
      body: body,
    );
  }
}
