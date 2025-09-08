class Movie {
  final String id;
  final String title;
  final String description;
  final String genre;
  final Duration duration;
  final String imageUrl;
  final double rating;
  final List<String> cast;
  final String director;
  final String writer; // Tambahkan field dari API
  final String status; // Tambahkan field dari API
  final String youtubeUrl; // Tambahkan field dari API
  final List<int> cinemaIds; // Tambahkan field dari API

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.genre,
    required this.duration,
    required this.imageUrl,
    required this.rating,
    required this.cast,
    required this.director,
    required this.writer,
    required this.status,
    required this.youtubeUrl,
    required this.cinemaIds,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      genre: json['genre'] ?? '',
      duration: _parseDuration(json['duration'] ?? '02:00'),
      imageUrl: json['image_url'] ?? json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      cast: List<String>.from(json['cast'] ?? []),
      director: json['director'] ?? '',
      writer: json['writer'] ?? '',
      status: json['status'] ?? '',
      youtubeUrl: json['youtube_url'] ?? json['youtubeUrl'] ?? '',
      cinemaIds: List<int>.from(json['cinema_ids'] ?? []),
    );
  }

  static Duration _parseDuration(dynamic duration) {
    try {
      if (duration is String) {
        final parts = duration.split(':');
        if (parts.length == 2) {
          return Duration(
            hours: int.parse(parts[0]),
            minutes: int.parse(parts[1]),
          );
        }
      } else if (duration is int) {
        return Duration(minutes: duration);
      }
    } catch (e) {
      print('Error parsing duration: $e');
    }
    return const Duration(hours: 2);
  }
}
