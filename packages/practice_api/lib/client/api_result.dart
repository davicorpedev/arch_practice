import 'package:equatable/equatable.dart';

class ApiResult extends Equatable {
  final dynamic response;

  const ApiResult._(this.response);

  factory ApiResult.from(dynamic decodedResponse) =>
      ApiResult._(decodedResponse);

  @override
  List<Object?> get props => [response];
}
