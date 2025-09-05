class Showtime {
  final String id;
  final String movieId;
  final DateTime dateTime;
  final String theater;
  final double price;
  final List<List<bool>> seats;

  Showtime({
    required this.id,
    required this.movieId,
    required this.dateTime,
    required this.theater,
    required this.price,
    required this.seats,
  });

  factory Showtime.fromJson(Map<String, dynamic> json) {
    return Showtime(
      id: json['id'] ?? '',
      movieId: json['movieId'] ?? '',
      dateTime: DateTime.parse(json['dateTime'] ?? DateTime.now().toString()),
      theater: json['theater'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      seats: _parseSeats(json['seats'] ?? []),
    );
  }

  static List<List<bool>> _parseSeats(List<dynamic> seatsJson) {
    try {
      return seatsJson.map<List<bool>>((row) {
        return row.map<bool>((seat) => seat == true).toList();
      }).toList();
    } catch (e) {
      print('Error parsing seats: $e');
      return List.generate(5, (i) => List.generate(8, (j) => true));
    }
  }
}
