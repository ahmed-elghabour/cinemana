import 'package:bloc/bloc.dart';
import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/domain/usecase/get_usecase.dart';
import 'package:equatable/equatable.dart';

part 'movie_recommendations_state.dart';

class MovieRecommendationsCubit extends Cubit<MovieRecommendationsState> {
  final GetUsecase getMovieRecommendationUsecase;
  MovieRecommendationsCubit({required this.getMovieRecommendationUsecase})
      : super(GetMovieRecommendationsInitial());

  void getMovieRecommendations(int id) async {
    emit(GetMovieRecommendationsLoading());
    final result = await getMovieRecommendationUsecase.execute(id);
    //emit(GetMoviesSuccess(result.fold((l) => , (r) => r)));
    result.fold(
      (l) {
        emit(GetMovieRecommendationsFail());
      },
      (r) {
        emit(GetMovieRecommendationsSuccess(r));
      },
    );
  }
}
