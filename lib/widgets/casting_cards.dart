import 'package:fl_peliculas/providers/movies_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';

class CastingCards extends StatelessWidget {

  final int movieId;

  const CastingCards({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: ( _ , AsyncSnapshot<List<Cast>> snapshot) {
        
        if( !snapshot.hasData ){
          return Container(
            constraints: const BoxConstraints(maxWidth: 100),
            margin: const EdgeInsets.only(bottom: 30),
            height: 50,
            child: const CupertinoActivityIndicator()
          );
        } else {

          final casts = snapshot.data!;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: casts.length,
              itemBuilder: ( _ , int index ) =>  _CastCard(cast: casts[index])
            ),
          );
        }
    
      }
    );


    
  }
}

class _CastCard extends StatelessWidget {

  final Cast cast;

  const _CastCard({ 
    Key? key,
    required this.cast,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:  FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'), 
              image: NetworkImage(cast.profileImg),
              width: 100,
              fit: BoxFit.cover
            ),
          ),

          const SizedBox(height: 5,),

          Text(
            cast.name,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}