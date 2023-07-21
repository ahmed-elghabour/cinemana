import 'dart:ui';

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
                      backgroundColor: const Color.fromARGB(255, 0, 0, 33),
                      expandedHeight: 300.0,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            ShaderMask(
                              shaderCallback: (Rect rect) {
                                return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    // fromLTRB
                                    Colors.black,
                                    Colors.black,
                                    Colors.transparent,
                                    Colors.transparent,
                                  ],
                                  stops: [0, 0.6, 0.8, 1],
                                ).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height),
                                );
                              },
                              blendMode: BlendMode.dstIn,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: _getImageOrNotFound(state)
                                        as ImageProvider,
                                  ),
                                ),
                              ),
                            ),
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                              child: Center(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0)),
                                    child: Container(
                                      height: 250,
                                      width: 180,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16.0))),
                                      child: Utils.getMovieImage(
                                        backdropPath:
                                            state.movieDetails.backdropPath,
                                        isNowPlaying: false,
                                        context: context,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: FadeInUp(
                        from: 20,
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                state.movieDetails.title,
                                style: GoogleFonts.lilitaOne(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16.0),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(70, 0, 217, 255),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        state.movieDetails.releaseDate
                                            .split('-')[0],
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
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
                                      Row(children: [
                                        const Icon(
                                          Icons.access_time,
                                          size: 20.0,
                                        ),
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        Text(
                                          _showDuration(
                                              state.movieDetails.runtime),
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(249, 46, 49, 207),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 12.0),
                                  child: Text(
                                    _showGenres(state.movieDetails.genres),
                                    style: GoogleFonts.abrilFatface(
                                      color: Colors.white70,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                state.movieDetails.overview,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  height: 1.2,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              const SizedBox(height: 50.0),
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

  ImageProvider? _getImageOrNotFound(state) {
    if (state is GetMovieDetailsSuccess) {
      if (state.movieDetails.backdropPath != null) {
        return NetworkImage(StringConstants.imageUrl(
          state.movieDetails.backdropPath!,
        ));
      } else {
        return const NetworkImage(
          'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png',
        );
      }
    } else {
      return const NetworkImage(
        'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png',
      );
    }
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
