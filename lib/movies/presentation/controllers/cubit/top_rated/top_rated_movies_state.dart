part of 'top_rated_movies_cubit.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class GetMoviesInitial extends TopRatedMoviesState {}

class GetTopRatedMoviesLoading extends TopRatedMoviesState {}

class GetTopRatedMoviesFail extends TopRatedMoviesState {}

class GetTopRatedMoviesSuccess extends TopRatedMoviesState {
  final List<Movie> topRatedMovies;

  const GetTopRatedMoviesSuccess(this.topRatedMovies);
}
