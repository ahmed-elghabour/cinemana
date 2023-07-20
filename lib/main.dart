import 'package:cinemana/core/services/service_locator.dart';
import 'package:cinemana/movies/domain/usecase/get_now_playing_usecase.dart';
import 'package:cinemana/movies/domain/usecase/get_popular_usecase.dart';
import 'package:cinemana/movies/domain/usecase/get_top_rated_usecase.dart';
import 'package:cinemana/movies/domain/usecase/get_upcoming_usecase.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/now_playing/now_playing_movies_cubit.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/popular/popular_movies_cubit.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/top_rated/top_rated_movies_cubit.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/upcoming/upcoming_movies_cubit.dart';
import 'package:cinemana/movies/presentation/screens/movies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  ServiceLocator().initGetIt();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.indigoAccent.shade700.withAlpha(40),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                NowPlayingMoviesCubit(getUsecase: sl<GetNowPlayingUsecase>())
                  ..getNowPlayingMovies(),
          ),
          BlocProvider(
            create: (context) =>
                TopRatedMoviesCubit(getUsecase: sl<GetTopRatedUsecase>())
                  ..getTopRatedMovies(),
          ),
          BlocProvider(
            create: (context) =>
                PopularMoviesCubit(getUsecase: sl<GetPopularUsecase>())
                  ..getPopularMovies(),
          ),
          BlocProvider(
            create: (context) =>
                UpcomingMoviesCubit(getUsecase: sl<GetUpcomingUsecase>())
                  ..getUpcomingMovies(),
          ),
        ],
        child: const MoviesScreen(),
      ),
    );
  }
}
