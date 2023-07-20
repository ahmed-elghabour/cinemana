import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/domain/usecase/get_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final GetUsecase getUsecase;
  PopularMoviesCubit({required this.getUsecase}) : super(GetMoviesInitial());

  void getPopularMovies() async {
    emit(GetPopularMoviesLoading());
    final result = await getUsecase.execute(const NoParams());
    //emit(GetMoviesSuccess(result.fold((l) => , (r) => r)));
    result.fold(
      (l) {
        emit(GetPopularMoviesFail());
      },
      (r) {
        emit(GetPopularMoviesSuccess(r));
      },
    );
  }
}
