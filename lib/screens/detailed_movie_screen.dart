import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/consts.dart';
import '../models/movie_model.dart';

class DetailedMovieScreen extends StatefulWidget {
  const DetailedMovieScreen({super.key, required this.movieModel});
  final MovieModel movieModel;
  @override
  State<DetailedMovieScreen> createState() => _DetailedMovieScreenState();
}

class _DetailedMovieScreenState extends State<DetailedMovieScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movieModel.title,
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.movieModel.coverUrl,
                  width: size.width * 0.9,
                  height: size.height * 0.66,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.videocam_circle),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(widget.movieModel.directedBy.toString()),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.clock),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(widget.movieModel.duration.toString()),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text(widget.movieModel.overview.toString()),
              ),
              if (widget.movieModel.trailerUrl != null)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      onPressed: () {
                        launchUrl(Uri.parse(widget.movieModel.trailerUrl!));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "WATCH TRAILER",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Icon(CupertinoIcons.play_arrow, color: Colors.white)
                        ],
                      )),
                ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
