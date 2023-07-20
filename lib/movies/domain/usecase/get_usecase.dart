import 'package:cinemana/core/error/failure.dart';
import 'package:cinemana/movies/domain/repository/base_movies_repository.dart';
import 'package:dartz/dartz.dart';

abstract class GetUsecase<T, Params> {
  final BaseMoviesRepository baseMoviesRepository;

  GetUsecase(this.baseMoviesRepository);
  Future<Either<Failure, T>> execute(Params params);
}

class NoParams {
  const NoParams();
}
