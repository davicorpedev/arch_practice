import 'package:practice_api/client/api_requester.dart';
import 'package:practice_api/models/ai_image_model.dart';

abstract class ApiClient {
  Future<List<AiImageModel>> loadImages({required String prompt});
}

class HttpApiClient implements ApiClient {
  final ApiRequester _requester;

  HttpApiClient({required ApiRequester requester}) : _requester = requester;

  @override
  Future<List<AiImageModel>> loadImages({required String prompt}) async {
    final body = {
      "prompt": prompt,
      "n": 4,
    };

    final result = await _requester.performPostRequest(
      path: 'images/generations',
      body: body,
    );

    return result
        .map<AiImageModel>((image) => AiImageModel.fromJson(image))
        .toList();
  }
}
