part of 'movie_details_cubit.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

//Details
class GetMovieDetailsInitial extends MovieDetailsState {}

class GetMovieDetailsLoading extends MovieDetailsState {}

class GetMovieDetailsFail extends MovieDetailsState {}

class GetMovieDetailsSuccess extends MovieDetailsState {
  final MovieDetails movieDetails;

  const GetMovieDetailsSuccess(this.movieDetails);
}
