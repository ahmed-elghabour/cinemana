import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemana/core/utils/constant_strings.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

abstract class Utils {
  static Widget getMovieImage({
    required String? backdropPath,
    required bool isNowPlaying,
    required BuildContext context,
  }) {
    if (isNowPlaying) {
      if (backdropPath == null) {
        return const Image(
          width: double.infinity,
          fit: BoxFit.cover,
          image: AssetImage('lib/core/utils/assets/image-not-available.jpg'),
        );
      } else {
        return CachedNetworkImage(
          height: MediaQuery.sizeOf(context).height / 1.7,
          width: double.infinity,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 500),
          imageUrl: StringConstants.imageUrl(backdropPath),
        );
      }
    } else {
      if (backdropPath == null) {
        return const Image(
          width: 120.0,
          height: 170.0,
          fit: BoxFit.cover,
          image: AssetImage('lib/core/utils/assets/image-not-available.jpg'),
        );
      } else {
        return CachedNetworkImage(
          width: 120.0,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 500),
          imageUrl: StringConstants.imageUrl(backdropPath),
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[850]!,
            highlightColor: Colors.grey[800]!,
            child: const SizedBox(
              height: 170.0,
              width: 120.0,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      }
    }
  }
}
