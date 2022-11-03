import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletons/skeletons.dart';

/** Component use for assetImage, networkImage, svg */

class ImageWidget extends StatelessWidget {
  const ImageWidget(
    this.url, {
    Key? key,
    this.width = 80,
    this.height = 80,
    this.fit = BoxFit.cover,
    this.color,
    this.cacheKey,
    this.semanticsLabel,
    this.radius,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  final double width;
  final double height;
  final BoxFit fit;
  final String url;
  final Color? color;
  final String? cacheKey;
  final String? semanticsLabel;
  final double? radius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    if (url.contains('svg')) {
      return SvgPicture.asset(
        url,
        semanticsLabel: semanticsLabel,
        fit: fit,
        width: width,
        height: height,
      );
    }

    if (url.contains('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: fit,
        cacheKey: cacheKey,
        placeholder: ((context, url) => SkeletonAvatar(
              style: SkeletonAvatarStyle(
                shape: shape,
                width: width,
                height: height,
              ),
            )),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        imageBuilder: (context, imageProvider) => shape == BoxShape.circle
            ? CircleAvatar(
                backgroundColor: color,
                radius: (width / 2) + 2,
                child: CircleAvatar(
                  radius: (width / 2),
                  backgroundImage: imageProvider,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(radius ?? 2),
                child: Image(
                  image: imageProvider,
                  width: width,
                  height: height,
                  fit: fit,
                ),
              ),
      );
    }
    return Image.asset(
      url,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
