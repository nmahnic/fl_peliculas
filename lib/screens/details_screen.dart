import 'package:fl_peliculas/theme/app_theme.dart';
import 'package:fl_peliculas/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
   
  const DetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    //TODO: cambiar luego por una instlancia de movie

    // final String _movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              const [
                _PosterAndTitle(),
                _Overview(),
                _Overview(),
                CastingCards()
              ]
            )
          )
        ],
      )
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        'Aute qui amet in occaecat do irure duis dolor. Esse minim fugiat sint enim do sunt Lorem ea commodo ea. Officia sint aliquip anim eiusmod dolor ea nostrud Lorem consequat sit et et deserunt esse.',
        textAlign: TextAlign.justify,
        style: AppTheme.getSubTitle(context),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric( horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              height: 150,
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
            ),
          ),

          const SizedBox(width: 20,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start ,
            children: [
              Text('movie.title', overflow: TextOverflow.ellipsis, maxLines: 2, style: AppTheme.getTitle(context),),
              Text('movie.originalTitle', overflow: TextOverflow.ellipsis, maxLines: 1, style: AppTheme.getSubTitle(context)),
              Row(
                children: const [
                  Icon(Icons.star_border),
                  Icon(Icons.star_border),
                  Icon(Icons.star_border),
                  Icon(Icons.star_border),
                  Icon(Icons.star_border),
                ],
              ),
              Text('movie.voteAvarage', overflow: TextOverflow.ellipsis, maxLines: 1, style: AppTheme.getCaption(context)),
            ],
          )
        ]
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.only(bottom: 10),
          color: Colors.black12,
          child: const Text('movie.title')
        ),
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage('https://via.placeholder.com/300x400'),
          fit: BoxFit.cover
        ),
      ),
    );
  }
}