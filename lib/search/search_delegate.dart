

import 'package:fl_peliculas/providers/movies_providers.dart';
import 'package:fl_peliculas/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String get searchFieldLabel => 'Buscar Película';


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon( Icons.clear),
        onPressed: () => { query = '' }, 
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon( Icons.arrow_back),
      onPressed: () => {
        close(context, null)
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    
    if( query.isEmpty){
      return const _EmptyMovieContainer();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: ( _ , AsyncSnapshot<List<Movie>> snapshot) {

        if( !snapshot.hasData ){
          return const _EmptyMovieContainer();
        }


        final movie = snapshot.data!;

        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: movie.length,
          itemBuilder: ( _ , int index ) =>  _MovieCard(movie: movie[index])
        );
      },
    );

  }

}

class _EmptyMovieContainer extends StatelessWidget {
  const _EmptyMovieContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon( Icons.movie_creation_outlined, color: Colors.black38, size: 130)
    );
  }
}


class _MovieCard extends StatelessWidget {

  final Movie movie;

  const _MovieCard({ 
    Key? key,
    required this.movie,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage( movie.fullPostImg ),
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () => { Navigator.pushNamed(context, '/details', arguments: movie)},
    );
  }
}