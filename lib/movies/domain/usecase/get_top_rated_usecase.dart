import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/domain/repository/base_movies_repository.dart';

class GetTopRatedUsecase {
  final BaseMoviesRepository baseMoviesRepository;

  GetTopRatedUsecase(this.baseMoviesRepository);

  Future<List<Movie>> execute() async {
    return await baseMoviesRepository.getTopRated();
  }
}
