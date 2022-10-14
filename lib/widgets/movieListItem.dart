import 'package:flutter/material.dart';

import '../models/movie.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  final onDeleteItem;

  const MovieListItem(
      {super.key, required this.movie, required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: 300,
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          tileColor: Color.fromARGB(88, 217, 217, 217),
          leading: Icon(
            movie.rating! > 3 ? Icons.star : Icons.star_border_outlined,
            color: const Color.fromARGB(255, 217, 210, 0),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                movie.name,
              ),
              Text(
                movie.rating.toString(),
              ),
            ],
          ),
          trailing: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              color: Colors.white,
              iconSize: 18,
              icon: Icon(Icons.delete),
              onPressed: () {
                onDeleteItem(movie.referenceId);
              },
            ),
          ),
          onTap: null),
    );
  }
}
