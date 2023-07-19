part of 'popular_movies_cubit.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class GetMoviesInitial extends PopularMoviesState {}

class GetPopularMoviesLoading extends PopularMoviesState {}

class GetPopularMoviesFail extends PopularMoviesState {}

class GetPopularMoviesSuccess extends PopularMoviesState {
  final List<Movie> popularMovies;

  const GetPopularMoviesSuccess(this.popularMovies);
}
