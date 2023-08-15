import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider with ChangeNotifier {
  List<MovieModel> movies = [];

  bool isLoading = false;

  setLoading(bool status) {
    Timer(const Duration(milliseconds: 5), () {
      isLoading = status;
      notifyListeners();
    });
  }

  fetcMovies() async {
    setLoading(true);
    final response =
        await http.get(Uri.parse("https://mcuapi.herokuapp.com/api/v1/movies"));

    if (response.statusCode == 200) {
      print(response.body);

      var decodedData = json.decode(response.body)["data"];

      decodedData.forEach((movie) {
        movies.add(MovieModel.fromJson(movie));
      });
    } else {
      print("Error");
    }

    setLoading(false);
  }
}
