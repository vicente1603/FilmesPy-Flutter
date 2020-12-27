import 'dart:convert';


MovieModel movieModelFromJson(String str) =>
    MovieModel.fromJson(json.decode(str));

String movieModelToJson(MovieModel data) =>
    json.encode(data.toJson());

class MovieModel {
  String data;
  String genero;
  String link;
  String poster;
  String sinopse;
  String sinopseFull;
  String titulo;

  MovieModel(
      {this.data,
      this.genero,
      this.link,
      this.poster,
      this.sinopse,
      this.sinopseFull,
      this.titulo});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      data: json["data"],
      genero: json["genero"],
      link: json["link"],
      poster: json["poster"],
      sinopse: json["sinopse"],
      sinopseFull: json["sinopseFull"],
      titulo: json["titulo"]
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data,
        "genero": genero,
        "link": link,
        "poster": poster,
        "sinopse": sinopse,
        "sinopseFull": sinopseFull,
        "titulo": titulo
      };
}
