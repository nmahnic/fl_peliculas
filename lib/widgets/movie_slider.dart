import 'package:fl_peliculas/models/movie.dart';
import 'package:flutter/material.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({ 
    Key? key, 
    required this.movies, 
    required this.onNextPage,
    this.title,
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {

      if( scrollController.position.pixels+300 >= scrollController.position.maxScrollExtent ){
        print(scrollController.position.pixels);
        print(scrollController.position.maxScrollExtent);
        widget.onNextPage();
      }
      
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: 250,
      // color: Colors.red,
      child: Column(
        children: [

          if( widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(widget.title!, style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold),)
              ),
            ),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: ( _ , int index ) =>  _MoviePoster(movie: widget.movies[index])
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
            onTap: () => Navigator.pushNamed(context, '/details', arguments: movie),
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