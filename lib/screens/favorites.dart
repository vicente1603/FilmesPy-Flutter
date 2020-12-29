import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../blocs/favorite_bloc.dart';
import '../models/movie_model.dart';
import 'movie_detail.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.green[200],
      body: StreamBuilder<Map<String, MovieModel>>(
        stream: bloc.outFav,
        initialData: {},
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((movie) {
              return InkWell(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 120.0,
                      height: 70.0,
                      child: Image.network(movie.poster),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        movie.titulo,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(5.0, 5.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Shadow(
                                offset: Offset(5.0, 5.0),
                                blurRadius: 8.0,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        bloc.toggleFavorite(movie);
                      },
                    )
                  ],
                ),
                onTap: () {
                  MovieModel movieDetail = movie;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MovieDetail(movieDetail)));
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
