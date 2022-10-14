import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../screens/movieList.dart';
import 'dart:async';

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  // TO ADD BACK LATER
  //final movieList = Movie.movieList();

  final _movieNameController = TextEditingController();
  final _movieRatingController = TextEditingController();
  var movieList = Movie.movieList();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50, bottom: 50),
            child: const Text(
              'Add a Movie',
              style: TextStyle(fontSize: 30),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Movie Title', hintText: 'The Departed'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: _movieNameController,
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Movie Rating', hintText: '1 - 5'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a number';
              }
              return null;
            },
            controller: _movieRatingController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  addMovieItem(_movieNameController.text,
                      _movieRatingController.hashCode);
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  void addMovieItem(String name, int rating) {
    setState(() {
      var movie = Movie(
          referenceId: DateTime.now().millisecondsSinceEpoch.toString(),
          name: name,
          rating: rating);
      streamController.add(movie);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieList(
                    stream: streamController.stream,
                  )));
    });
  }
}
