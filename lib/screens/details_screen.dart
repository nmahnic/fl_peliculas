import 'package:fl_peliculas/theme/app_theme.dart';
import 'package:fl_peliculas/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class DetailsScreen extends StatelessWidget {
   
  const DetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    //TODO: cambiar luego por una instlancia de movie

    final Movie _movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: _movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(movie: _movie),
                _Overview(textOverview: _movie.overview),
                CastingCards( movieId: _movie.id)
              ]
            )
          )
        ],
      )
    );
  }
}

class _Overview extends StatelessWidget {

  final String textOverview;

  const _Overview({ 
    Key? key,
    required this.textOverview,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        textOverview,
        textAlign: TextAlign.justify,
        style: AppTheme.getSubTitle(context),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle({
    Key? key, 
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric( horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                height: 150,
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPostImg),
              ),
            ),
          ),

          const SizedBox(width: 20,),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                Text(movie.title, overflow: TextOverflow.ellipsis, maxLines: 2, style: AppTheme.getTitle(context),),
                Text(movie.originalTitle, overflow: TextOverflow.ellipsis, maxLines: 1, style: AppTheme.getSubTitle(context)),
                Row(
                  children: [
                    const Icon(Icons.star_border),
                    Text(movie.voteAverage.toString(), overflow: TextOverflow.ellipsis, maxLines: 1, style: AppTheme.getCaption(context)),
                  ],
                ),
              ],
            ),
          )
        ]
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  
  final Movie movie;

  const _CustomAppBar({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.primaryColor,
      expandedHeight: 200,
      stretch: true,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          color: Colors.black12,
          child: Text(movie.title)
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'), 
          image: NetworkImage(movie.fullBackdropImg),
          fit: BoxFit.cover
        ),
      ),
    );
  }
}