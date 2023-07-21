import 'package:cinemana/movies/domain/entities/movie_details.dart';
import 'package:cinemana/movies/domain/usecase/get_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final GetUsecase getMovieDetailsUsecase;

  MovieDetailsCubit({
    required this.getMovieDetailsUsecase,
  }) : super(GetMovieDetailsInitial());

  void getMovieDetails(int id) async {
    emit(GetMovieDetailsLoading());
    final result = await getMovieDetailsUsecase.execute(id);
    //emit(GetMoviesSuccess(result.fold((l) => , (r) => r)));
    result.fold(
      (l) {
        emit(GetMovieDetailsFail());
      },
      (r) {
        emit(GetMovieDetailsSuccess(r));
      },
    );
  }
}
