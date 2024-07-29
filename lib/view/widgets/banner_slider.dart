import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task/model/model.dart';
import 'package:task/utils/constants/constants.dart';

class BannerSliderWidget extends StatelessWidget {
  final List<Content> contents;

  const BannerSliderWidget(this.contents, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenFullHeight * .17,
      child: PageView(
        children: contents.map((content) {
          return CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: content.imageUrl!,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
        }).toList(),
      ),
    );
  }
}
