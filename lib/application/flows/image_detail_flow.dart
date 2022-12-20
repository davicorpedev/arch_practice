import 'package:arch_practice/presentation/pages/image_detail/image_detail_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:practice_repositories/entities/ai_image.dart';

List<Page<dynamic>> onGenerateImageDetailPages(
  ImageDetail detail,
  List<Page<dynamic>> pages,
) {
  return [
    MaterialPage<void>(child: ImageDetailPage(image: detail.image)),
  ];
}

class ImageDetailFlow extends StatelessWidget {
  final AiImage image;

  const ImageDetailFlow({super.key, required this.image});

  static Route<ImageDetail> route({required AiImage image}) {
    return MaterialPageRoute(builder: (_) => ImageDetailFlow(image: image));
  }

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<ImageDetail>(
      state: ImageDetail(image: image),
      onGeneratePages: onGenerateImageDetailPages,
    );
  }
}

class ImageDetail extends Equatable {
  const ImageDetail({required this.image});

  final AiImage image;

  ImageDetail copyWith({AiImage? image}) {
    return ImageDetail(
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [image];
}
