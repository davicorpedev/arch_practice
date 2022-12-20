import 'package:equatable/equatable.dart';

class AiImage extends Equatable {
  final String url;

  const AiImage({required this.url});

  @override
  List<Object?> get props => [url];
}
