
import 'package:fl_peliculas/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

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
            onPressed: () => {}, 
            icon: const Icon( Icons.search_rounded)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
      
            CardSwiper( movies: moviesProvider.onDisplayMovies ),

            const SizedBox(height: 10,),
      
            MovieSlider( movies: moviesProvider.onPopularMovies, title: 'Populares!'),
      
          ],
        ),
      )
    );
  }
}