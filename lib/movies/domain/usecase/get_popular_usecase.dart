import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/domain/repository/base_movies_repository.dart';

class GetPupularUsecase {
  final BaseMoviesRepository baseMoviesRepository;

  GetPupularUsecase(this.baseMoviesRepository);

  Future<List<Movie>> execute() async {
    return await baseMoviesRepository.getPopular();
  }
}
