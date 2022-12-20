import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;

  const CustomNetworkImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress == null) return child;

        return const SizedBox(
          height: 120,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
