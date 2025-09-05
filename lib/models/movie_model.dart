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
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      genre: json['genre'] ?? '',
      duration: _parseDuration(json['duration'] ?? '02:00'),
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      cast: List<String>.from(json['cast'] ?? []),
      director: json['director'] ?? '',
    );
  }

  static Duration _parseDuration(String duration) {
    try {
      final parts = duration.split(':');
      if (parts.length == 2) {
        return Duration(
          hours: int.parse(parts[0]),
          minutes: int.parse(parts[1]),
        );
      }
    } catch (e) {
      print('Error parsing duration: $e');
    }
    return const Duration(hours: 2);
  }
}
