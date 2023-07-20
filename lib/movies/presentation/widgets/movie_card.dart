import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemana/core/services/service_locator.dart';
import 'package:cinemana/core/utils/constant_strings.dart';
import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/domain/usecase/get_movie_details_usecase.dart';
import 'package:cinemana/movies/domain/usecase/get_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          GetUsecase g = GetMovieDetailsUsecase(sl());
          g.execute(movie.id);
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: Stack(
            alignment: Alignment.topRight,
            fit: StackFit.passthrough,
            /* clipBehavior: Clip.hardEdge, */
            children: [
              CachedNetworkImage(
                width: 120.0,
                fit: BoxFit.cover,
                imageUrl: StringConstants.imageUrl(movie.backdropPath),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[850]!,
                  highlightColor: Colors.grey[800]!,
                  child: const SizedBox(
                    height: 170.0,
                    width: 120.0,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Positioned(
                right: 4,
                top: 4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    color: Colors.blue.withOpacity(.6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.yellowAccent,
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Text(movie.voteAverage.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
