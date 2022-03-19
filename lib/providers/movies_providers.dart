import 'package:fl_peliculas/models/models.dart';
import 'package:fl_peliculas/models/populars_response.dart';
import 'package:fl_peliculas/models/search_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {

  final String _apiKey = '44b2d7f8d7950335502b8c5d180b9ea0';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];

  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;

  MoviesProvider(){
    print('MoviesProvider inicializado');

    getOnDisplayMovies();
    getPopularMovies();
  }
   
  getOnDisplayMovies() async {
    final bareResponse = await _doHttpReq('3/movie/now_playing', 1);
    final nowPlayingResponse = NowPlayingResponse.fromJson(bareResponse['body']);
    // Await the http get response, then decode the json-formatted response.
    print('Main Request with status: ${bareResponse['resCode']}.');
    if (bareResponse['resCode'] == 200) { 
      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
     }
  }

  getPopularMovies() async {
    _popularPage++;
    final bareResponse = await _doHttpReq('3/movie/popular', _popularPage);
    final popularsResponse = PopularsResponse.fromJson(bareResponse['body']);
    // Await the http get response, then decode the json-formatted response.
    print('Populars Request with status: ${bareResponse['resCode']}.');
    if (bareResponse['resCode'] == 200) { 
      onPopularMovies = [...onPopularMovies, ...popularsResponse.results];
      notifyListeners();
     }
  }

  Future<Map<String, dynamic>> _doHttpReq(String endpoint, [int page = 1, String? query]) async{
    final url = Uri.https(_baseUrl, endpoint, 
      {
        'api_key': _apiKey,
        'language': _language,
        'page': '$page',
        'query': query
      }
    );

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return {'body': response.body, 'resCode': response.statusCode};
  }

  Future<List<Cast>> getMovieCast( int movieId ) async {

    if( movieCast.containsKey(movieId)) return movieCast[movieId]!;

    final bareResponse = await _doHttpReq('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(bareResponse['body']);
    // Await the http get response, then decode the json-formatted response.
    print('Credits Request with status: ${bareResponse['resCode']}.');
    if (bareResponse['resCode'] == 200) { 
      movieCast[movieId] = creditsResponse.cast;
    }

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie ( String query ) async {

    final bareResponse = await _doHttpReq('3/search/movie', 1, query);
    final searchResponse = SearchResponse.fromJson(bareResponse['body']);
    // Await the http get response, then decode the json-formatted response.
    print('Credits Request with status: ${bareResponse['resCode']}.');
    if (bareResponse['resCode'] == 200) { 
      
    }

    return searchResponse.results;

  }

 }