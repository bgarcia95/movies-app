import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'f4d30dfea84b32afbba315fe5d1ed849';
  String _baseURL = 'api.themoviedb.org';
  String _language = 'en-EN';

  List<Movie> nowPlayingMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider() {
    print('MoviesProvider initialized');

    getNowPlayingMovies();
    getPopularMovies();
  }

  // square brackets makes page parameter optional and assigns a default value of 1
  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseURL, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });

    final response = await http.get(url);
    return response.body;
  }

  getNowPlayingMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(jsonData);

    nowPlayingMovies = nowPlayingResponse.results;

    // this will make all listeners to redraw all widgets linked to this data
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromRawJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) {
      return moviesCast[movieId]!;
    }

    print('asking info to server - Cast');

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromRawJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
