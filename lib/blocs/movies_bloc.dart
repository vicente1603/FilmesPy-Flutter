import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:flutter_movies/services/movies_service.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc implements BlocBase {
  MovieService api;
  List<MovieModel> movies;

  final StreamController<List<MovieModel>> _moviesController =
      StreamController<List<MovieModel>>.broadcast();

  Stream get outMovies => _moviesController.stream;

  final StreamController<String> _searchController = StreamController<String>();

  Sink get inSearch => _searchController.sink;

  MoviesBloc() {
    api = MovieService();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    _moviesController.sink.add([]);
    _moviesController.sink.add(movies);
  }

  @override
  void dispose() {
    _moviesController.close();
    _searchController.close();
  }
}
