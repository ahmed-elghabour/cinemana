import 'package:cinemana/movies/domain/entities/movie.dart';
import 'package:cinemana/movies/domain/usecase/get_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upcoming_movies_state.dart';

class UpcomingMoviesCubit extends Cubit<UpcomingMoviesState> {
  final GetUsecase getUsecase;
  UpcomingMoviesCubit({required this.getUsecase}) : super(GetMoviesInitial());

  void getUpcomingMovies() async {
    emit(GetUpcomingMoviesLoading());
    final result = await getUsecase.execute(const NoParams());
    //emit(GetMoviesSuccess(result.fold((l) => , (r) => r)));
    result.fold(
      (l) {
        emit(GetUpcomingMoviesFail());
      },
      (r) {
        emit(GetUpcomingMoviesSuccess(r));
      },
    );
  }
}
