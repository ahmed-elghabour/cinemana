import 'package:cinemana/core/error/failure.dart';
import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/domain/usecase/get_usecase.dart';
import 'package:dartz/dartz.dart';

class GetRecommendationUsecase extends GetUsecase<List<Movie>, int> {
  GetRecommendationUsecase(super.baseMoviesRepository);

  @override
  Future<Either<Failure, List<Movie>>> execute(int params) async {
    return await baseMoviesRepository.getRecommendation(params);
  }
}
