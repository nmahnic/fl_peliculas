
import 'package:fl_peliculas/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../search/search_delegate.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        actions: [
          IconButton(
            icon: const Icon( Icons.search_rounded),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()), 
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
      
            CardSwiper( movies: moviesProvider.onDisplayMovies ),

            const SizedBox(height: 10,),
      
            MovieSlider( 
              movies: moviesProvider.onPopularMovies, 
              onNextPage: () => { moviesProvider.getPopularMovies() },
              title: 'Populares!'),
      
          ],
        ),
      )
    );
  }
}