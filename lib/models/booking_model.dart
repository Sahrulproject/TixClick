class Booking {
  final String id;
  final String userId;
  final String showtimeId;
  final List<String> seatNumbers;
  final DateTime bookingTime;
  final double totalPrice;
  final String status;

  Booking({
    required this.id,
    required this.userId,
    required this.showtimeId,
    required this.seatNumbers,
    required this.bookingTime,
    required this.totalPrice,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      showtimeId: json['showtimeId'] ?? '',
      seatNumbers: List<String>.from(json['seatNumbers'] ?? []),
      bookingTime: DateTime.parse(
        json['bookingTime'] ?? DateTime.now().toString(),
      ),
      totalPrice: (json['totalPrice'] ?? 0.0).toDouble(),
      status: json['status'] ?? 'confirmed',
    );
  }
}
