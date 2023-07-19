part of 'upcoming_movies_cubit.dart';

abstract class UpcomingMoviesState extends Equatable {
  const UpcomingMoviesState();

  @override
  List<Object> get props => [];
}

class GetMoviesInitial extends UpcomingMoviesState {}

class GetUpcomingMoviesLoading extends UpcomingMoviesState {}

class GetUpcomingMoviesFail extends UpcomingMoviesState {}

class GetUpcomingMoviesSuccess extends UpcomingMoviesState {
  final List<Movie> upcomingMovies;

  const GetUpcomingMoviesSuccess(this.upcomingMovies);
}
