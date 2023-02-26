import 'dart:typed_data';
import 'package:flutter/material.dart';

class UTILImage extends StatelessWidget {
  final dynamic image;
  final String? placeHolder;
  final BoxFit fit;

  const UTILImage({Key? key, required this.image, this.placeHolder, this.fit = BoxFit.contain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image is Uint8List) {
      return getMemoryImage();
    } else if (image.toString().startsWith("http")) {
      return getNetworkImage();
    } else {
      return getAssectImage();
    }
  }

  Widget getNetworkImage() {
    if (placeHolder != null) {
      return FadeInImage.assetNetwork(
          placeholder: placeHolder!,
          image: image,
          fit: fit,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(placeHolder!, fit: fit);
          });
    } else {
      return Image.network(
        image,
        fit: fit,
      );
    }
  }

  Widget getMemoryImage() {
    return Image.memory(
      image,
      fit: fit,
    );
  }

  Widget getAssectImage() {
    return Image.asset(
      image,
      fit: fit,
    );
  }
}
