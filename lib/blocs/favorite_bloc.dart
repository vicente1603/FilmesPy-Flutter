import 'dart:async';
import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase {
  Map<String, MovieModel> _favorites = {};

  final _favController =
  BehaviorSubject<Map<String, MovieModel>>(seedValue: {});

  Stream<Map<String, MovieModel>> get outFav => _favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favorites")) {
        _favorites = json.decode(prefs.getString("favorites")).map((k, v) {
          return MapEntry(k, MovieModel.fromJson(v));
        }).cast<String, MovieModel>();
        _favController.add(_favorites);
      }
    });
  }

  void toggleFavorite(MovieModel movie) {
    if (_favorites.containsKey(movie.titulo))
      _favorites.remove(movie.titulo);
    else
      _favorites[movie.titulo] = movie;

    _favController.sink.add(_favorites);
    _saveFav();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("favorites", json.encode(_favorites));
    });
  }

  @override
  void dispose() {
    _favController.close();
  }
}
