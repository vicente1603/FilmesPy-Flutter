import 'dart:convert';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:http/http.dart' as http;

const API_KEY = "19f5325275524d1d4f39fcb8c06a1761";

class MovieService {
  String _search;

  static Future<List<MovieModel>> getMovies() async {
    try {
      final response = await http.get(
          "https://filmespy.herokuapp.com/api/v1/filmes");

      if (response.statusCode == 200) {
        Map data = json.decode(response.body);

        final movies = (data["filmes"] as List)
            .map((i) => new MovieModel.fromJson(i))
            .toList();

        return movies;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<MovieModel>> search(String search) async {
    _search = search;

    http.Response response = await http.get(
        "https://api.themoviedb.org/3/movie/popular?api_key=${API_KEY}&language=en-US&page=1");

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<MovieModel> movies = (decoded["filmes"] as List)
          .map((i) => new MovieModel.fromJson(i))
          .toList();

      if (_search == null) {
        return movies;
      } else {
        List<MovieModel> result =
            movies.where((movie) => movie.titulo.contains(search)).toList();
        return result;
      }
    } else {
      throw Exception("Fail");
    }
  }
}
