import 'package:cinemana/core/error/exceptions.dart';
import 'package:cinemana/core/error/failure.dart';
import 'package:cinemana/movies/data/datasource/movie_remote_data_source.dart';
import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/domain/entities/movie_details.dart';
import 'package:cinemana/movies/domain/entities/recommendation.dart';
import 'package:cinemana/movies/domain/repository/base_movies_repository.dart';
import 'package:dartz/dartz.dart';

class MoviesRepository implements BaseMoviesRepository {
  final BaseMovieDataSource baseMovieDataSource;

  MoviesRepository({
    required this.baseMovieDataSource,
  });

  @override
  Future<Either<Failure, List<Movie>>> getNowPlaying() async {
    final result = await baseMovieDataSource.getNowPlaying();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopular() async {
    final result = await baseMovieDataSource.getPopular();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRated() async {
    final result = await baseMovieDataSource.getTopRated();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcoming() async {
    final result = await baseMovieDataSource.getUpcoming();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(int movieId) async {
    final result = await baseMovieDataSource.getMovieDetails(movieId);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Recommendation>>> getRecommendation(
      int movieId) async {
    final result = await baseMovieDataSource.getRecommendation(movieId);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
