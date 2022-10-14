import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/widgets/movieListItem.dart';

import '../models/movie.dart';
import '../widgets/form.dart';
import 'home.dart';

import 'dart:async';

StreamController<Movie> streamController = StreamController<Movie>();
StreamSubscription<Movie>? subscription;

class MovieList extends StatefulWidget {
  MovieList({super.key, required this.stream});
  final Stream<Movie> stream;
  //final _myController = BehaviorSubject(); // Second attempt at stream
  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List movieList = [];
  var initMovieList = Movie.movieList();

  @override
  void initState() {
    super.initState();
    setUpMovies();
    // getting error here because i want to only look for stream after a save
    // or change the broadcast stream to an observable
    widget.stream.asBroadcastStream().listen((movie) {
      updateMovieListState(movie);
    });
  }

  void updateMovieListState(Movie movie) {
    setState(() {
      movieList.add(Movie(
          referenceId: DateTime.now().millisecondsSinceEpoch.toString(),
          name: movie.name,
          rating: movie.rating));
    });
  }

  setUpMovies() async {
    for (var movie in initMovieList) {
      setState(() {
        movieList.add(movie);
      });
    }
  }

  void _deletMovieItem(String movieId) {
    setState(() {
      movieList.removeWhere((movie) => (movie.referenceId == movieId));
    });
  }

  @override
  @mustCallSuper
  @protected
  void dispose() {
    subscription = streamController.stream.listen(((event) async {
      await subscription?.cancel();
    }));
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 197, 140, 17),
        title: const Text(
          'All Movies',
        ),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 50, bottom: 50),
            child: const Text(
              'All Movies',
              style: TextStyle(fontSize: 30),
            ),
          ),
          for (Movie movieeeeee in movieList)
            MovieListItem(
              movie: movieeeeee,
              onDeleteItem: _deletMovieItem,
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 197, 140, 17),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MovieForm()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MovieForm extends StatefulWidget {
  const MovieForm({super.key});
  @override
  State<MovieForm> createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Add Movie"),
          backgroundColor: const Color.fromARGB(255, 197, 140, 17),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              const MyCustomForm(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                },
                child: const Text('Back to home'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieList(
                                stream: streamController.stream,
                              )));
                },
                child: const Text('Movie List'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
