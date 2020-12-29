import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/blocs/favorite_bloc.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:flutter_movies/services/movies_service.dart';
import 'package:flutter_movies/widgets/movie_tile.dart';

import 'favorites.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmes PY", style: TextStyle(color: Colors.white)),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, MovieModel>>(
              stream: BlocProvider.of<FavoriteBloc>(context).outFav,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.length.toString(),
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
            tooltip: "Lista de favoritos",
            icon: Icon(
              Icons.star,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Favorites()));
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.green[200],
        child: FutureBuilder<List<MovieModel>>(
          future: MovieService.getMovies(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(height: 2, color: Colors.black);
                },
                itemBuilder: (context, index) {
                  return MovieTile(snapshot.data[index]);
                },
                itemCount: snapshot.data.length,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
