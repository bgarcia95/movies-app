import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier {
  MoviesProvider() {
    print('MoviesProvider initialized');

    getNowPlayingMovies();
  }

  getNowPlayingMovies() async {
    print('getOnDisplayMovies');
  }
}
