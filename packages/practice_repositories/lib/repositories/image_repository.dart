import 'package:practice_api/datasources/image_data_source.dart';
import 'package:practice_api/error/exceptions.dart';
import 'package:practice_repositories/entities/ai_image.dart';
import 'package:practice_repositories/entities/result.dart';
import 'package:practice_repositories/error/failures.dart';
import 'package:practice_repositories/utils/network_info.dart';

abstract class ImageRepository {
  Future<Result<List<AiImage>>> loadImages({required String prompt});
}

class ImageRepositoryImpl implements ImageRepository {
  final ImageDataSource _dataSource;
  final NetworkInfo _networkInfo;

  ImageRepositoryImpl({
    required ImageDataSource dataSource,
    required NetworkInfo networkInfo,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo;

  @override
  Future<Result<List<AiImage>>> loadImages({required String prompt}) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _dataSource.loadImages(prompt: prompt);

        return Result.success(result);
      } on ServerException {
        return Result.error(ServerFailure());
      }
    } else {
      return Result.error(NetworkFailure());
    }
  }
}
