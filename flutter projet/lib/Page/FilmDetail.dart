import 'package:flutter/material.dart';
import 'package:moviesapp/config/ConfigOMDB.dart';
import 'package:moviesapp/film/MovieInfo.dart';
import 'package:moviesapp/components/PaddedText.dart';

class MovieDetail extends StatelessWidget {
  final String movieName;
  final String imdbId;

  MovieDetail({this.movieName, this.imdbId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.movieName),
        backgroundColor: Colors.black54,
      ),
      body: FutureBuilder<MovieInfo>(
          future: getMovie(this.imdbId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          alignment: Alignment.center,
                          child: Image.network(
                            snapshot.data.poster,
                            width: 180,
                          ),
                        ),
                        Text(snapshot.data.plot, textAlign: TextAlign.justify),
                        PaddedText("Année : " + snapshot.data.year),
                        PaddedText("Genre : " + snapshot.data.genre),
                        PaddedText("Réalisé par : " + snapshot.data.director),
                        PaddedText("Temps : " + snapshot.data.runtime),
                        PaddedText("IMDB Score : " + snapshot.data.imdbRating +"/10"),
                      ]));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
