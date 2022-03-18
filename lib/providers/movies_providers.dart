import 'package:fl_peliculas/models/models.dart';
import 'package:fl_peliculas/models/populars_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {

  final String _apiKey = '44b2d7f8d7950335502b8c5d180b9ea0';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];

  MoviesProvider(){
    print('MoviesProvider inicializado');

    getOnDisplayMovies();
    getPopularMovies();
  }
   
  getOnDisplayMovies() async {
    final url = Uri.https(_baseUrl, '3/movie/now_playing', 
      {
        'api_key': _apiKey,
        'language': _language,
        'page': '1'     
      }
    );

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    // Await the http get response, then decode the json-formatted response.
    print('Request failed with status: ${response.statusCode}.');
    if (response.statusCode == 200) { 
      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
     }
  }

  getPopularMovies() async {
    final url = Uri.https(_baseUrl, '3/movie/popular', 
      {
        'api_key': _apiKey,
        'language': _language,
        'page': '1'     
      }
    );

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final popularsResponse = PopularsResponse.fromJson(response.body);
    // Await the http get response, then decode the json-formatted response.
    print('Request failed with status: ${response.statusCode}.');
    if (response.statusCode == 200) { 
      onPopularMovies = [...onPopularMovies, ...popularsResponse.results];
      notifyListeners();
     }
  }

 }