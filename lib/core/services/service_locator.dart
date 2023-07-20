import 'package:cinemana/movies/data/datasource/movie_remote_data_source.dart';
import 'package:cinemana/movies/data/repository/movies_repository.dart';
import 'package:cinemana/movies/domain/repository/base_movies_repository.dart';
import 'package:cinemana/movies/domain/usecase/get_movie_details_usecase.dart';
import 'package:cinemana/movies/domain/usecase/get_now_playing_usecase.dart';
import 'package:cinemana/movies/domain/usecase/get_popular_usecase.dart';
import 'package:cinemana/movies/domain/usecase/get_top_rated_usecase.dart';
import 'package:cinemana/movies/domain/usecase/get_upcoming_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void initGetIt() {
    sl.registerLazySingleton<BaseMovieDataSource>(
        () => MovieRemoteDataSource());
    sl.registerLazySingleton<BaseMoviesRepository>(
        () => MoviesRepository(baseMovieDataSource: sl()));
    sl.registerLazySingleton(() => GetNowPlayingUsecase(sl()));
    sl.registerLazySingleton(() => GetTopRatedUsecase(sl()));
    sl.registerLazySingleton(() => GetPopularUsecase(sl()));
    sl.registerLazySingleton(() => GetUpcomingUsecase(sl()));
    sl.registerLazySingleton(() => GetMovieDetailsUsecase(sl()));
  }
}
