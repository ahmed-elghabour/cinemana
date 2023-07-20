import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/domain/usecase/get_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  final GetUsecase getUsecase;
  TopRatedMoviesCubit({required this.getUsecase}) : super(GetMoviesInitial());

  void getTopRatedMovies() async {
    emit(GetTopRatedMoviesLoading());
    final result = await getUsecase.execute(const NoParams());
    //emit(GetMoviesSuccess(result.fold((l) => , (r) => r)));
    result.fold(
      (l) {
        emit(GetTopRatedMoviesFail());
      },
      (r) {
        emit(GetTopRatedMoviesSuccess(r));
      },
    );
  }
}
