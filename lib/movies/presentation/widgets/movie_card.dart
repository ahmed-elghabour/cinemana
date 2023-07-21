import 'package:cinemana/core/utils/utils.dart';
import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/presentation/screens/movie_details_screen.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  MovieDetailsScreen(id: movie.id),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: Stack(
            alignment: Alignment.topRight,
            fit: StackFit.passthrough,
            /* clipBehavior: Clip.hardEdge, */
            children: [
              Utils.getMovieImage(
                backdropPath: movie.backdropPath,
                isNowPlaying: false,
                context: context,
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
                          Text(movie.voteAverage.toString().substring(0, 3)),
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
