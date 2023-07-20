import 'package:cinemana/core/error/error_message_model.dart';
import 'package:cinemana/core/error/exceptions.dart';
import 'package:cinemana/core/utils/constant_strings.dart';
import 'package:cinemana/movies/data/models/movie_details_model.dart';
import 'package:cinemana/movies/data/models/movie_model.dart';
import 'package:cinemana/movies/data/models/recommendation_model.dart';
import 'package:dio/dio.dart';

abstract class BaseMovieDataSource {
  Future<List<MovieModel>> getNowPlaying();
  Future<List<MovieModel>> getTopRated();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getUpcoming();
  Future<List<RecommendationModel>> getRecommendation(int movieId);
  Future<MovieDetailsModel> getMovieDetails(int movieId);
}

class MovieRemoteDataSource extends BaseMovieDataSource {
  @override
  Future<List<MovieModel>> getNowPlaying() async {
    final response = await Dio().get(StringConstants.nowPlayingPath);

    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data["results"] as List).map(
        (e) => MovieModel.fromJson(e),
      ));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    final response = await Dio().get(StringConstants.popularPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data["results"] as List).map(
        (e) => MovieModel.fromJson(e),
      ));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> getTopRated() async {
    final response = await Dio().get(StringConstants.topRatedPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data["results"] as List).map(
        (e) => MovieModel.fromJson(e),
      ));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> getUpcoming() async {
    final response = await Dio().get(StringConstants.upconmingPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data["results"] as List).map(
        (e) => MovieModel.fromJson(e),
      ));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final response = await Dio().get(StringConstants.movieUrl(movieId));
    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<RecommendationModel>> getRecommendation(int movieId) async {
    final response =
        await Dio().get(StringConstants.recommendationUrl(movieId));

    if (response.statusCode == 200) {
      return List<RecommendationModel>.from(
          (response.data["results"] as List).map(
        (e) => RecommendationModel.fromJson(e),
      ));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
