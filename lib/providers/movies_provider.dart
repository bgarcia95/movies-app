import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'f4d30dfea84b32afbba315fe5d1ed849';
  String _baseURL = 'api.themoviedb.org';
  String _language = 'en-EN';

  List<Movie> nowPlayingMovies = [];

  MoviesProvider() {
    print('MoviesProvider initialized');

    getNowPlayingMovies();
  }

  getNowPlayingMovies() async {
    var url = Uri.https(_baseURL, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(response.body);

    nowPlayingMovies = nowPlayingResponse.results;

    // this will make all listeners to redraw all widgets linked to this data
    notifyListeners();
  }
}
