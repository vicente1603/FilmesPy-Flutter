import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/blocs/movies_bloc.dart';
import 'package:flutter_movies/widgets/movie_tile.dart';

class MovieResults extends StatelessWidget {
  String result;

  MovieResults(this.result);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MoviesBloc>(context);
    bloc.inSearch.add(result);
    return Scaffold(
        appBar: AppBar(
          title: Text("Resultado da pesquisa"),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          color: Colors.lightBlue[200],
          child: StreamBuilder(
            stream: bloc.outMovies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return MovieTile(snapshot.data[index]);
                    },
                    itemCount: snapshot.data.length,
                  );
                } else {
                  return Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Nenhum filme encontrado.",
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
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  );
                }
              } else {
                return Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Nenhum filme encontrado.",
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
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ));
  }
}
