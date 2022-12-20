import 'package:practice_repositories/entities/ai_image.dart';

class AiImageModel extends AiImage {
  const AiImageModel({required String url}) : super(url: url);

  factory AiImageModel.fromJson(Map<String, dynamic> json) {
    return AiImageModel(
      url: json['url'],
    );
  }
}
