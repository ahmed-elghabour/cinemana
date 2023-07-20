import 'package:cinemana/core/error/failure.dart';
import 'package:cinemana/movies/domain/entities/movie_details.dart';
import 'package:cinemana/movies/domain/usecase/get_usecase.dart';
import 'package:dartz/dartz.dart';

class GetMovieDetailsUsecase extends GetUsecase<MovieDetails, int> {
  GetMovieDetailsUsecase(super.baseMoviesRepository);

  @override
  Future<Either<Failure, MovieDetails>> execute(int params) async {
    return await baseMoviesRepository.getMovieDetails(params);
  }
}
