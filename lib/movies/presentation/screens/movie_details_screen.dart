import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemana/core/services/service_locator.dart';
import 'package:cinemana/core/utils/constant_strings.dart';
import 'package:cinemana/core/utils/utils.dart';
import 'package:cinemana/movies/domain/entities/genres.dart';
import 'package:cinemana/movies/domain/usecase/get_movie_details_usecase.dart';
import 'package:cinemana/movies/domain/usecase/get_recommendation_usecase.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/movie_details/movie_details_cubit.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/recommendations/movie_recommendations_cubit.dart';
import 'package:cinemana/movies/presentation/widgets/movies_category_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int id;

  const MovieDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => MovieDetailsCubit(
                  getMovieDetailsUsecase: sl<GetMovieDetailsUsecase>(),
                )..getMovieDetails(id)),
        BlocProvider(
            create: (context) => MovieRecommendationsCubit(
                  getMovieRecommendationUsecase: sl<GetRecommendationUsecase>(),
                )..getMovieRecommendations(id)),
      ],
      child: const Scaffold(
        body: MovieDetailsContent(),
      ),
    );
  }
}

class MovieDetailsContent extends StatelessWidget {
  const MovieDetailsContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
            builder: (context, state) {
              if (state is GetMovieDetailsSuccess) {
                return CustomScrollView(
                  key: const Key('movieDetailScrollView'),
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor:
                          Colors.indigoAccent.shade700.withAlpha(40),
                      expandedHeight: 250.0,
                      flexibleSpace: FlexibleSpaceBar(
                          background: Utils.getMovieImage(
                              backdropPath: state.movieDetails.backdropPath,
                              isNowPlaying: false)),
                    ),
                    SliverToBoxAdapter(
                      child: FadeInUp(
                        from: 20,
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.movieDetails.title,
                                  style: GoogleFonts.poppins(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                  )),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2.0,
                                      horizontal: 8.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      state.movieDetails.releaseDate
                                          .split('-')[0],
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20.0,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        (state.movieDetails.voteAverage)
                                            .toStringAsFixed(1),
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16.0),
                                  Text(
                                    _showDuration(state.movieDetails.runtime),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                state.movieDetails.overview,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Genres: ${_showGenres(state.movieDetails.genres)}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox(
                  height: 250.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
        BlocBuilder<MovieRecommendationsCubit, MovieRecommendationsState>(
          builder: (context, state) {
            if (state is GetMovieRecommendationsSuccess) {
              return MoviesCategory(
                  category: 'Recommended', movies: state.movieRecommendations);
            } else {
              return const SizedBox(
                height: 170.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}

String _showGenres(List<Genres> genres) {
  String result = '';
  for (var genre in genres) {
    result += '${genre.name}, ';
  }

  if (result.isEmpty) {
    return result;
  }

  return result.substring(0, result.length - 2);
}

String _showDuration(int runtime) {
  final int hours = runtime ~/ 60;
  final int minutes = runtime % 60;

  if (hours > 0) {
    return '${hours}h ${minutes}m';
  } else {
    return '${minutes}m';
  }
}
