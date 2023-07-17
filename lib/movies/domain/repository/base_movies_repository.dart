import 'package:cinemana/core/error/failure.dart';
import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';

abstract class BaseMoviesRepository {
  Future<Either<Failure, List<Movie>>> getNowPlaying();
  Future<Either<Failure, List<Movie>>> getPopular();
  Future<Either<Failure, List<Movie>>> getTopRated();
}
