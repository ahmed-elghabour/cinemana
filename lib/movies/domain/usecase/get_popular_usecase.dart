import 'package:cinemana/core/error/failure.dart';
import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/domain/repository/base_movies_repository.dart';
import 'package:dartz/dartz.dart';

class GetPupularUsecase {
  final BaseMoviesRepository baseMoviesRepository;

  GetPupularUsecase(this.baseMoviesRepository);

  Future<Either<Failure, List<Movie>>> execute() async {
    return await baseMoviesRepository.getPopular();
  }
}
