part of 'now_playing_movies_cubit.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class GetMoviesInitial extends NowPlayingMoviesState {}

class GetNowPlayingMoviesLoading extends NowPlayingMoviesState {}

class GetNowPlayingMoviesFail extends NowPlayingMoviesState {}

class GetNowPlayingMoviesSuccess extends NowPlayingMoviesState {
  final List<Movie> nowPlayingMovies;

  const GetNowPlayingMoviesSuccess(this.nowPlayingMovies);
}
