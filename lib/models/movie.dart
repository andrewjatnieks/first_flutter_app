import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Movie {
  String name;
  int? rating;
  String? referenceId;
  Movie({required this.name, this.rating, this.referenceId});

  get email => null;

  static List<Movie> movieList() {
    return [
      Movie(
        name: 'Pulp Fiction',
        rating: 5,
        referenceId: '01',
      ),
      Movie(
        name: 'Contact',
        rating: 4,
        referenceId: '02',
      ),
      Movie(
        name: 'Donnie Darko',
        rating: 3,
        referenceId: '03',
      ),
      Movie(
        name: 'Rocket Man',
        rating: 3,
        referenceId: '04',
      ),
      Movie(
        name: 'The Sandlot',
        rating: 1,
        referenceId: '05',
      ),
      Movie(
        name: 'Harry Potter',
        rating: 3,
        referenceId: '06',
      ),
      Movie(
        name: 'Bat-Man',
        rating: 3,
        referenceId: '07',
      ),
      Movie(
        name: '007',
        rating: 1,
        referenceId: '08',
      )
    ];
  }

  toJson() {
    return {"name": name, "rating": rating, "referenceId": referenceId};
  }

  fromJson(jsonData) {
    return Movie(
        name: jsonData['name'],
        rating: jsonData['rating'],
        referenceId: jsonData['referenceId']);
  }
}
