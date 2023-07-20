import 'package:cinemana/core/error/failure.dart';
import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/domain/usecase/get_usecase.dart';
import 'package:dartz/dartz.dart';

class GetNowPlayingUsecase extends GetUsecase<List<Movie>, NoParams> {
  GetNowPlayingUsecase(super.baseMoviesRepository);

  @override
  Future<Either<Failure, List<Movie>>> execute(NoParams params) async {
    return await baseMoviesRepository.getNowPlaying();
  }
}
