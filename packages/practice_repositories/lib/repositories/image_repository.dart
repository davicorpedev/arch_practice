import 'package:practice_api/client/api_client.dart';
import 'package:practice_api/error/exceptions.dart';
import 'package:practice_repositories/entities/ai_image.dart';
import 'package:practice_repositories/entities/result.dart';
import 'package:practice_repositories/error/failures.dart';
import 'package:practice_repositories/utils/network_info.dart';

abstract class ImageRepository {
  Future<Result<List<AiImage>>> loadImages({required String prompt});
}

class ImageRepositoryImpl implements ImageRepository {
  final ApiClient _apiClient;
  final NetworkInfo _networkInfo;

  ImageRepositoryImpl({
    required ApiClient apiClient,
    required NetworkInfo networkInfo,
  })  : _apiClient = apiClient,
        _networkInfo = networkInfo;

  @override
  Future<Result<List<AiImage>>> loadImages({required String prompt}) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _apiClient.loadImages(prompt: prompt);

        return Result.success(result);
      } on ServerException {
        return Result.error(ServerFailure());
      }
    } else {
      return Result.error(NetworkFailure());
    }
  }
}
