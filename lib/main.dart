import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/models/movie.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/screens/movieList.dart';

void main() {
  runApp(const MyMovieApp());
}

class MyMovieApp extends StatelessWidget {
  const MyMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home());
  }
}
