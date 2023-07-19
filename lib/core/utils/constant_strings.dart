class StringConstants {
  static const baseURL = 'https://api.themoviedb.org/3';
  static const apiKey = '77eba00c664ce81b67bc0185ed432d83';

  static const String nowPlayingPath =
      "$baseURL/movie/now_playing?api_key=$apiKey";
  static const String popularPath = "$baseURL/movie/popular?api_key=$apiKey";
  static const String topRatedPath = "$baseURL/movie/top_rated?api_key=$apiKey";

  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

  static String imageUrl(String path) => '$baseImageUrl$path';
}
