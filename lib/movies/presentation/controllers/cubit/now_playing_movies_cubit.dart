import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/domain/usecase/get_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  final GetUsecase getUsecase;
  NowPlayingMoviesCubit({required this.getUsecase}) : super(GetMoviesInitial());

  void getNowPlayingMovies() async {
    emit(GetNowPlayingMoviesLoading());
    final result = await getUsecase.execute();
    //emit(GetMoviesSuccess(result.fold((l) => , (r) => r)));
    result.fold(
      (l) {
        emit(GetNowPlayingMoviesFail());
      },
      (r) {
        emit(GetNowPlayingMoviesSuccess(r));
      },
    );
  }
}
