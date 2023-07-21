import 'package:cinemana/movies/data/datasource/movie_remote_data_source.dart';
import 'package:cinemana/movies/data/repository/movies_repository.dart';
import 'package:cinemana/movies/domain/repository/base_movies_repository.dart';
import 'package:cinemana/movies/domain/usecase/get_movie_details_usecase.dart';
import 'package:cinemana/movies/domain/usecase/get_now_playing_usecase.dart';
import 'package:cinemana/movies/domain/usecase/get_popular_usecase.dart';
import 'package:cinemana/movies/domain/usecase/get_recommendation_usecase.dart';
import 'package:cinemana/movies/domain/usecase/get_top_rated_usecase.dart';
import 'package:cinemana/movies/domain/usecase/get_upcoming_usecase.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/movie_details/movie_details_cubit.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/now_playing/now_playing_movies_cubit.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/popular/popular_movies_cubit.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/recommendations/movie_recommendations_cubit.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/top_rated/top_rated_movies_cubit.dart';
import 'package:cinemana/movies/presentation/controllers/cubit/upcoming/upcoming_movies_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void initGetIt() {
    //Data Sources
    sl.registerLazySingleton<BaseMovieDataSource>(
        () => MovieRemoteDataSource());

    //Repositories
    sl.registerLazySingleton<BaseMoviesRepository>(
        () => MoviesRepository(baseMovieDataSource: sl()));

    //Use Cases
    sl.registerLazySingleton(() => GetMovieDetailsUsecase(sl()));
    sl.registerLazySingleton(() => GetRecommendationUsecase(sl()));
    sl.registerLazySingleton(() => GetNowPlayingUsecase(sl()));
    sl.registerLazySingleton(() => GetPopularUsecase(sl()));
    sl.registerLazySingleton(() => GetTopRatedUsecase(sl()));
    sl.registerLazySingleton(() => GetUpcomingUsecase(sl()));

    //Cubits
    sl.registerFactory(() => MovieRecommendationsCubit(
        getMovieRecommendationUsecase: sl<GetRecommendationUsecase>()));
    sl.registerFactory(() => MovieDetailsCubit(
        getMovieDetailsUsecase: sl<GetMovieDetailsUsecase>()));
    sl.registerFactory(
        () => NowPlayingMoviesCubit(getUsecase: sl<GetNowPlayingUsecase>()));
    sl.registerFactory(
        () => PopularMoviesCubit(getUsecase: sl<GetPopularUsecase>()));
    sl.registerFactory(
        () => TopRatedMoviesCubit(getUsecase: sl<GetTopRatedUsecase>()));
    sl.registerFactory(
        () => UpcomingMoviesCubit(getUsecase: sl<GetUpcomingUsecase>()));
  }
}
