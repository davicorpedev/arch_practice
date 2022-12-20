import 'package:practice_repositories/error/failures.dart';

const String _serverFailureMessage =
    'There has been an error while trying to connect to the server';
const String _networkFailureMessage =
    'There is something wrong with your internet connection';
const String _unhandledFailure = 'Unhandled Failure';

extension Message on Failure {
  String get mapFailureToMessage {
    switch (runtimeType) {
      case ServerFailure:
        return _serverFailureMessage;
      case NetworkFailure:
        return _networkFailureMessage;
      default:
        return _unhandledFailure;
    }
  }
}
