import 'package:card_swiper/card_swiper.dart';
import 'package:fl_peliculas/models/movie.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper({
    Key? key, 
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;


    if(movies.isEmpty){
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemHeight: size.width * 0.9,
        itemWidth: size.width * 0.5,
        itemBuilder: (_ , int index) {

          final movie = movies[index];
          // print(movie.fullPostImg);

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: const AssetImage('assets/loading.gif'), 
                image: NetworkImage(movie.fullPostImg),
              ),
            ),
          );
        },

      )
    );
  }
}