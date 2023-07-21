import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemana/core/utils/dummy_movies.dart';
import 'package:cinemana/core/utils/utils.dart';
import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/now_playing/now_playing_movies_cubit.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/popular/popular_movies_cubit.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/top_rated/top_rated_movies_cubit.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/upcoming/upcoming_movies_cubit.dart';
import 'package:cinemana/movies/presentation/widgets/movies_category_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        key: const Key('movieScrollView'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesState>(
              builder: (context, state) {
                if (state is GetNowPlayingMoviesLoading) {
                  return const SizedBox(
                    height: 400.0,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is GetNowPlayingMoviesSuccess) {
                  return NowPlayingCategory(
                    movies: state.nowPlayingMovies,
                  );
                } else {
                  return NowPlayingCategory(
                    movies: moviesList,
                  );
                }
              },
            ),
            BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
              builder: (context, state) {
                if (state is GetPopularMoviesSuccess) {
                  return MoviesCategory(
                    category: 'Popular',
                    movies: state.popularMovies,
                  );
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
            BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
              builder: (context, state) {
                if (state is GetTopRatedMoviesSuccess) {
                  return MoviesCategory(
                    category: 'Top Rated',
                    movies: state.topRatedMovies,
                  );
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
            BlocBuilder<UpcomingMoviesCubit, UpcomingMoviesState>(
              builder: (context, state) {
                if (state is GetUpcomingMoviesSuccess) {
                  return MoviesCategory(
                    category: 'Upcoming',
                    movies: state.upcomingMovies,
                  );
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
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}

class NowPlayingCategory extends StatelessWidget {
  final List<Movie> movies;
  const NowPlayingCategory({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        viewportFraction: 1.0,
        onPageChanged: (index, reason) {},
      ),
      items: movies.map(
        (movie) {
          return GestureDetector(
            key: const Key('openMovieMinimalDetail'),
            onTap: () {
              /// TODO : NAVIGATE TO MOVIE DETAILS
            },
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        // fromLTRB
                        Colors.black,
                        Colors.black,
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0, 0.3, 0.6, 1],
                    ).createShader(
                      Rect.fromLTRB(0, 0, rect.width, rect.height),
                    );
                  },
                  blendMode: BlendMode.dstIn,
                  child: Utils.getMovieImage(
                      backdropPath: movie.backdropPath, isNowPlaying: true),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.redAccent,
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              'Now Playing'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          movie.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
