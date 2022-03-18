import 'package:fl_peliculas/models/movie.dart';
import 'package:flutter/material.dart';

class MovieSlider extends StatelessWidget {

  final List<Movie> movies;
  final String? title;

  const MovieSlider({ 
    Key? key, 
    required this.movies, 
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: 250,
      // color: Colors.red,
      child: Column(
        children: [

          if( title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(title!, style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold),)
              ),
            ),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: ( _ , int index ) =>  _MoviePoster(movie: movies[index])
            ),
          ),

        ]
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  
  final Movie movie;

  const _MoviePoster({ 
    Key? key, 
    required this.movie, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric( horizontal: 10, vertical: 10),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/details', arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/loading.gif'), 
                image: NetworkImage(movie.fullPostImg),
                width: 130,
                height: 180,
                fit: BoxFit.cover
              ),
            ),
          ),

          const SizedBox(height: 5,),

          const Text(
            'Titulo de Pelicula Pelicula Pelicula',
            // maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        ]
      ),
    );
  }
}