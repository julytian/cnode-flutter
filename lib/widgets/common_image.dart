import 'package:cached_network_image/cached_network_image.dart';
import 'package:cnode_flutter2/config/resource_manager.dart';
import 'package:flutter/material.dart';

enum ImageType {
  normal,
  random,
  assets,
}

class CommonImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final ImageType imageType;

  CommonImage({
    Key key,
    @required this.url,
    @required this.width,
    @required this.height,
    this.fit: BoxFit.cover,
    this.imageType = ImageType.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uri = imageUrl;
    if (uri.startsWith('//')) {
      uri = 'http:' + uri;
    }
    return CachedNetworkImage(
      imageUrl: uri,
      width: width,
      height: height,
      placeholder: (_, __) =>
          ImageHelper.placeHolder(width: width, height: height),
      errorWidget: (_, __, ___) =>
          ImageHelper.error(width: width, height: height),
      fit: fit,
    );
  }

  String get imageUrl {
    switch (imageType) {
      case ImageType.random:
        return ImageHelper.randomUrl(
          key: url,
          width: width.toInt(),
          height: height.toInt(),
        );
      case ImageType.assets:
        return ImageHelper.wrapAssets(url);
      case ImageType.normal:
        return url;
    }
    return url;
  }
}
