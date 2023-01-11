import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // here we are saying: go to the widgets tree, find the first instance of MoviesProvider and bring it here
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies in Theaters'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(movies: moviesProvider.nowPlayingMovies),
            const MovieSlider(),
          ],
        ),
      ),
    );
  }
}
