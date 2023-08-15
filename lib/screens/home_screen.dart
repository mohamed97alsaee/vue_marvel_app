import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vue_marvel_app/providers/movies_provider.dart';
import 'package:vue_marvel_app/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<MoviesProvider>(context, listen: false).fetcMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(builder: (context, movieProvider, child) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Image.asset("assets/marvel_logo.png", width: 100),
          ),
          body: movieProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  itemCount: movieProvider.movies.length,
                  padding: const EdgeInsets.all(24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: (1 / 1.5)),
                  itemBuilder: (context, index) {
                    return MovieCard(movieModel: movieProvider.movies[index]);
                  }));
    });
  }
}
