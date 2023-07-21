part of 'movie_recommendations_cubit.dart';

abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object> get props => [];
}

class GetMovieRecommendationsInitial extends MovieRecommendationsState {}

class GetMovieRecommendationsLoading extends MovieRecommendationsState {}

class GetMovieRecommendationsFail extends MovieRecommendationsState {}

class GetMovieRecommendationsSuccess extends MovieRecommendationsState {
  final List<Movie> movieRecommendations;

  const GetMovieRecommendationsSuccess(this.movieRecommendations);
}
