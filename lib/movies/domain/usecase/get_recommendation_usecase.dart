import 'package:cinemana/core/error/failure.dart';
import 'package:cinemana/movies/domain/entities/recommendation.dart';
import 'package:cinemana/movies/domain/usecase/get_usecase.dart';
import 'package:dartz/dartz.dart';

class GetRecommendationUsecase extends GetUsecase<List<Recommendation>, int> {
  GetRecommendationUsecase(super.baseMoviesRepository);

  @override
  Future<Either<Failure, List<Recommendation>>> execute(int params) async {
    return await baseMoviesRepository.getRecommendation(params);
  }
}
