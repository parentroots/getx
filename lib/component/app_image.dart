import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getx_template/component/loading/shimmer_box.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.src,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
  });

  final String src;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius borderRadius;

  bool get isNetwork => src.startsWith('http');
  bool get isSvg => src.toLowerCase().endsWith('.svg');
  bool get isAsset => !isNetwork;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: borderRadius, child: _buildImage(context));
  }

  Widget _buildImage(BuildContext context) {
    // 🌐 NETWORK IMAGE
    if (isNetwork && !isSvg) {
      return CachedNetworkImage(
        imageUrl: src,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => ShimmerBox(width: width, height: height),
        errorWidget: (context, url, error) => _error(context),
      );
    }

    // 🖼️ SVG IMAGE (asset or network)
    if (isSvg) {
      if (isNetwork) {
        return SvgPicture.network(
          src,
          width: width,
          height: height,
          fit: fit,
          placeholderBuilder: (context) =>
              ShimmerBox(width: width, height: height),
        );
      } else {
        return SvgPicture.asset(src, width: width, height: height, fit: fit);
      }
    }

    // 📁 ASSET IMAGE (jpg/png/etc)
    return Image.asset(
      src,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => _error(context),
    );
  }

  Widget _error(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const Center(child: Icon(Icons.image_not_supported_outlined)),
    );
  }
}
