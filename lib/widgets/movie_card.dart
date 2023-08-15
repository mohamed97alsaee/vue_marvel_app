import 'package:flutter/cupertino.dart';

import '../helpers/consts.dart';
import '../models/movie_model.dart';
import 'package:flutter/material.dart';

import '../screens/detailed_movie_screen.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({super.key, required this.movieModel});
  final MovieModel movieModel;
  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) =>
                    DetailedMovieScreen(movieModel: widget.movieModel)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GridTile(
          footer: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    Colors.black12,
                    Colors.transparent,
                  ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movieModel.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.movieModel.releaseDate,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
          child: Image.network(
            widget.movieModel.coverUrl,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
