import 'package:cinemana/core/error/failure.dart';
import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/domain/usecase/get_usecase.dart';
import 'package:dartz/dartz.dart';

class GetPopularUsecase extends GetUsecase<List<Movie>, NoParams> {
  GetPopularUsecase(super.baseMoviesRepository);

  @override
  Future<Either<Failure, List<Movie>>> execute(NoParams params) async {
    return await baseMoviesRepository.getPopular();
  }
}
