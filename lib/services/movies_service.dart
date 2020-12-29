import 'dart:convert';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:http/http.dart' as http;

const API_KEY = "19f5325275524d1d4f39fcb8c06a1761";

class MovieService {

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
}
