import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tixclick/models/movie_model.dart';
import 'package:tixclick/models/showtime_model.dart';
import 'package:tixclick/api/endpoint/endpoint.dart'; // Import endpoint
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Method untuk mendapatkan token dari shared preferences
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Headers dengan authorization
  static Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // GET movies dari API real
  static Future<List<Movie>> getMovies() async {
    try {
      final response = await http.get(
        Uri.parse(Endpoint.films),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }

  // GET movie detail dari API real
  static Future<Movie> getMovieDetail(String id) async {
    try {
      final response = await http.get(
        Uri.parse('${Endpoint.films}/$id'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        return Movie.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load movie detail: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load movie detail: $e');
    }
  }

  // GET showtimes dari API real
  static Future<List<Showtime>> getShowtimes(String movieId) async {
    try {
      final response = await http.get(
        Uri.parse('${Endpoint.showtimes}?movie_id=$movieId'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Showtime.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load showtimes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load showtimes: $e');
    }
  }

  // POST booking tickets
  static Future<bool> bookTickets(
    String showtimeId,
    List<String> seatNumbers,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(Endpoint.showtimes),
        headers: await _getHeaders(),
        body: json.encode({
          'showtime_id': showtimeId,
          'seat_numbers': seatNumbers,
        }),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}
