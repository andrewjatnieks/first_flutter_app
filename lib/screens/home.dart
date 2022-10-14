import 'package:flutter/material.dart';
import 'package:todo/widgets/movieListItem.dart';

import '../models/movie.dart';
import 'movieList.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 197, 140, 17),
          title: const Text(
            'Home',
          ),
        ),
        body: Center(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/assets/images/dance.jpg'),
                  fit: BoxFit.fill),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MovieForm()));
                  },
                  child: const Icon(Icons.add),
                )
              ],
            ),
          ),
        ));
  }
}
