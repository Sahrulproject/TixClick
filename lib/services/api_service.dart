import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tixclick/models/movie_model.dart';
import 'package:tixclick/models/showtime_model.dart';

class ApiService {
  static const String baseUrl = 'https://your-api-url.com/api';

  static Future<List<Movie>> getMovies() async {
    // Simulasi data untuk demo
    await Future.delayed(const Duration(seconds: 2));

    // Data dummy sebagai pengganti API
    final dummyMovies = [
      {
        'id': '1',
        'title': 'Avengers: Endgame',
        'description':
            'Continuing Avengers Infinity War, the events take place after Thanos successfully acquired all the Infinity Stones and wiped out 50% of all life in the universe. Will the Avengers succeed in defeating Thanos.',
        'genre': 'Action, Adventure',
        'duration': '03:01',
        'imageUrl': 'https://via.placeholder.com/300x450?text=Avengers',
        'rating': 8.4,
        'cast': ['Robert Downey Jr.', 'Chris Evans', 'Mark Ruffalo'],
        'director': 'Anthony Russo, Joe Russo',
      },
      {
        'id': '2',
        'title': 'The Batman',
        'description':
            'When the Riddler, a sadistic serial killer, begins murdering prominent political figures in Gotham, Batman is called upon to investigate the citys hidden corruption and question his familys involvement.',
        'genre': 'Action, Crime',
        'duration': '02:56',
        'imageUrl': 'https://via.placeholder.com/300x450?text=Batman',
        'rating': 7.8,
        'cast': ['Robert Pattinson', 'Zoë Kravitz', 'Paul Dano'],
        'director': 'Matt Reeves',
      },
      {
        'id': '3',
        'title': 'Spider-Man: No Way Home',
        'description':
            'For the first time in Spider-Man screen history, the affable heros true identity is revealed, bringing his superpowered responsibilities into conflict with his normal life, and putting everyone closest to him at risk.',
        'genre': 'Action, Adventure',
        'duration': '02:28',
        'imageUrl': 'https://via.placeholder.com/300x450?text=Spider-Man',
        'rating': 8.2,
        'cast': ['Tom Holland', 'Zendaya', 'Benedict Cumberbatch'],
        'director': 'Jon Watts',
      },
    ];

    return dummyMovies.map((json) => Movie.fromJson(json)).toList();
  }

  static Future<Movie> getMovieDetail(String id) async {
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy
    final dummyMovie = {
      'id': id,
      'title': 'Movie $id',
      'description':
          'Description for movie $id. This is a great movie with amazing actors and storyline.',
      'genre': 'Action, Adventure',
      'duration': '02:30',
      'imageUrl': '$id',
      'rating': 8.0,
      'cast': ['Actor 1', 'Actor 2', 'Actor 3'],
      'director': 'Director Name',
    };

    return Movie.fromJson(dummyMovie);
  }

  static Future<List<Showtime>> getShowtimes(String movieId) async {
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy
    final now = DateTime.now();
    final dummyShowtimes = [
      {
        'id': '1',
        'movieId': movieId,
        'dateTime': now.add(const Duration(hours: 2)).toString(),
        'theater': 'Theater 1',
        'price': 45000.0,
        'seats': List.generate(
          5,
          (i) => List.generate(8, (j) => j != 2 && j != 5),
        ),
      },
      {
        'id': '2',
        'movieId': movieId,
        'dateTime': now.add(const Duration(hours: 5)).toString(),
        'theater': 'Theater 2',
        'price': 50000.0,
        'seats': List.generate(
          5,
          (i) => List.generate(8, (j) => j != 3 && j != 6),
        ),
      },
    ];

    return dummyShowtimes.map((json) => Showtime.fromJson(json)).toList();
  }

  static Future<bool> bookTickets(
    String showtimeId,
    List<String> seatNumbers,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    // Simulasi booking berhasil
    return true;
  }
}
