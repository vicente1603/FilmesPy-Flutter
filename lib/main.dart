import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/blocs/movies_bloc.dart';
import 'package:flutter_movies/screens/home.dart';
import 'blocs/favorite_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: MoviesBloc(),
      child: BlocProvider(
        bloc: FavoriteBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FlutterMovies',
          theme: ThemeData(
            primarySwatch: Colors.green,
            primaryColor: Colors.green[400],
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Home(),
        ),
      ),
    );
  }
}
