import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movies_app/common/Constants.dart';
import 'package:movies_app/model/Media.dart';
import 'package:movies_app/common/MediaProvider.dart';
import 'package:movies_app/model/Cast.dart';


class HttpHandler{

  static final _httpHandler = HttpHandler();
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  static HttpHandler get(){
    return _httpHandler;
  }

  Future<dynamic> getJson(Uri uri) async {
    http.Response response = await http.get(uri);
    return json.decode(response.body);

  }

  Future<List<Media>> fetchMovies({String category : "popular"}) async {
    var uri = Uri.https(_baseUrl, "3/movie/$category", {
      "api_key": api_key,
      "page": "1",
      "languaje": _language
    });

    return getJson(uri).then(((data) => 
      data['results'].map<Media>((item) => Media(item, MediaType.movie)).toList()
    ));
  }

  Future<List<Media>> fetchShow({String category : "popular"}) async {
    var uri = Uri.https(_baseUrl, "3/tv/$category", {
      "api_key": api_key,
      "page": "1",
      "languaje": _language
    });

    return getJson(uri).then(((data) => 
      data['results'].map<Media>((item) => Media(item, MediaType.show)).toList()
    ));
  }


  Future<List<Cast>> fetchCreditMovies(int mediaId) async {
    var uri = Uri.https(_baseUrl, "3/movie/$mediaId/credits", {
      "api_key": api_key,
      "page": "1",
      "languaje": _language
    });

    return getJson(uri).then(((data) => 
      data['cast'].map<Cast>((item) => Cast(item, MediaType.movie)).toList()
    ));
  }

  Future<List<Cast>> fetchCreditShow(int mediaId) async {
    var uri = Uri.https(_baseUrl, "3/tv/$mediaId/credits", {
      "api_key": api_key,
      "page": "1",
      "languaje": _language
    });

    return getJson(uri).then(((data) => 
      data['cast'].map<Cast>((item) => Cast(item, MediaType.show)).toList()
    ));
  }
 
}