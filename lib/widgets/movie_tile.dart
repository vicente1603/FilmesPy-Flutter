import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/blocs/favorite_bloc.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:flutter_movies/screens/movie_detail.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieTile extends StatelessWidget {
  final MovieModel movie;
  SharedPreferences prefs;

  MovieTile(this.movie);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);
    return ListTile(
      isThreeLine: true,
      contentPadding: EdgeInsets.all(16),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            movie.poster,
            fit: BoxFit.contain,
            width: 100,
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Text(movie.titulo,
                    textAlign: TextAlign.center,
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
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          StreamBuilder<Map<String, MovieModel>>(
            stream: bloc.outFav,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return IconButton(
                  icon: Icon(
                    snapshot.data.containsKey(movie.titulo)
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (snapshot.data.containsKey(movie.titulo)) {
                      bloc.toggleFavorite(movie);
                    } else {
                      if (snapshot.data.length < 3) {
                        bloc.toggleFavorite(movie);
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) => NetworkGiffyDialog(
                                  image: Image.network(
                                    "https://media1.giphy.com/media/YlRlDeOtR5fAnUXhVf/source.gif",
                                    fit: BoxFit.cover,
                                  ),
                                  entryAnimation: EntryAnimation.TOP,
                                  title: Text(
                                    'Você já possui favoritos o suficiente!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  description: Text(
                                    'Só é permitido salvar até 3 filmes nos seus favoritos',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  onOkButtonPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ));
                      }
                    }
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
      subtitle: Text(
        movie.sinopse,
        textAlign: TextAlign.justify,
      ),
      onTap: () {
        MovieModel movieDetail = movie;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MovieDetail(movieDetail)));
      },
    );
  }
}
