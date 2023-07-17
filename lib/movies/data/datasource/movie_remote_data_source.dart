import 'package:cinemana/core/utils/api_constants.dart';
import 'package:cinemana/movies/data/models/movie_model.dart';
import 'package:dio/dio.dart';

abstract class BaseMovieDataSource {
  Future<List<MovieModel>> getNowPlaying();
  Future<List<MovieModel>> getTopRated();
  Future<List<MovieModel>> getPopular();
}

class MovieRemoteDataSource implements BaseMovieDataSource {
  @override
  Future<List<MovieModel>> getNowPlaying() async {
    final response = await Dio().get(APIConstants.nowPlayingPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data["results"] as List).map(
        (e) => MovieModel.fromJson(e),
      ));
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    final response = await Dio().get(APIConstants.popularPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data["results"] as List).map(
        (e) => MovieModel.fromJson(e),
      ));
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<MovieModel>> getTopRated() async {
    final response = await Dio().get(APIConstants.topRatedPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data["results"] as List).map(
        (e) => MovieModel.fromJson(e),
      ));
    } else {
      throw Exception();
    }
  }
}
