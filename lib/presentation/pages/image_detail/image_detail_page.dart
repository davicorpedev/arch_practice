import 'package:arch_practice/application/flows/image_detail_flow.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:practice_repositories/entities/ai_image.dart';

class ImageDetailPage extends StatelessWidget {
  final AiImage image;

  const ImageDetailPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.flow<ImageDetail>().complete(),
        ),
      ),
      body: Center(
        child: Image.network(image.url),
      ),
    );
  }
}
