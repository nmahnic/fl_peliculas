import 'package:flutter/material.dart';

class MovieSlider extends StatelessWidget {

  const MovieSlider({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      // color: Colors.red,
      child: Column(
        children: [

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Populares', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: ( _ , int index ) =>  const _MoviePoster()
            ),
          ),

        ]
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({
    Key? key,
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
              child:  const FadeInImage(
                placeholder: AssetImage('assets/loading.gif'), 
                image: NetworkImage('https://via.placeholder.com/300x400'),
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