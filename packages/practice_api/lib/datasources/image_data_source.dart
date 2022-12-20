import 'package:practice_api/client/api_client.dart';
import 'package:practice_api/models/ai_image_model.dart';

abstract class ImageDataSource {
  Future<List<AiImageModel>> loadImages({required String prompt});
}

class ImageDataSourceImpl implements ImageDataSource {
  final ApiClient _client;

  ImageDataSourceImpl({required ApiClient client}) : _client = client;

  @override
  Future<List<AiImageModel>> loadImages({required String prompt}) async {
    final result = await _client.loadImages(prompt: prompt);

    return result.response
        .map<AiImageModel>((image) => AiImageModel.fromJson(image))
        .toList();
  }
}
