import 'package:arch_practice/application/flows/image_detail_flow.dart';
import 'package:arch_practice/presentation/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:practice_repositories/entities/ai_image.dart';

class CustomMasonryGridView extends StatelessWidget {
  final List<AiImage> images;

  const CustomMasonryGridView({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      itemCount: images.length,
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final image = images[index];

        return InkWell(
          child: CustomNetworkImage(url: image.url),
          onTap: () {
            Navigator.of(context).push(
              ImageDetailFlow.route(image: image),
            );
          },
        );
      },
    );
  }
}
