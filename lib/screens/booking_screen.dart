import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../models/showtime_model.dart';
import '../services/api_service.dart';
import '../widgets/seat_widget.dart';
import 'confirmation_screen.dart';

class BookingScreen extends StatefulWidget {
  final Showtime showtime;
  final Movie movie;

  const BookingScreen({Key? key, required this.showtime, required this.movie})
    : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<String> selectedSeats = [];

  void _toggleSeat(int row, int col) {
    setState(() {
      final seatNumber = '${String.fromCharCode(65 + row)}${col + 1}';
      if (selectedSeats.contains(seatNumber)) {
        selectedSeats.remove(seatNumber);
      } else {
        selectedSeats.add(seatNumber);
      }
    });
  }

  Future<void> _bookTickets() async {
    if (selectedSeats.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one seat')),
      );
      return;
    }

    final success = await ApiService.bookTickets(
      widget.showtime.id,
      selectedSeats,
    );

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationScreen(
            movie: widget.movie,
            showtime: widget.showtime,
            seats: selectedSeats,
            totalPrice: selectedSeats.length * widget.showtime.price,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.movie.title}'),
        backgroundColor: const Color(0xFF0F1B2B),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.movie.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Theater: ${widget.showtime.theater}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Time: ${widget.showtime.dateTime.hour}:${widget.showtime.dateTime.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Screen',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.showtime.seats.isNotEmpty
                    ? widget.showtime.seats[0].length
                    : 8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount:
                  widget.showtime.seats.length *
                  (widget.showtime.seats.isNotEmpty
                      ? widget.showtime.seats[0].length
                      : 8),
              itemBuilder: (context, index) {
                final row =
                    index ~/
                    (widget.showtime.seats.isNotEmpty
                        ? widget.showtime.seats[0].length
                        : 8);
                final col =
                    index %
                    (widget.showtime.seats.isNotEmpty
                        ? widget.showtime.seats[0].length
                        : 8);

                if (row < widget.showtime.seats.length &&
                    col < widget.showtime.seats[row].length) {
                  final isAvailable = widget.showtime.seats[row][col];
                  final seatNumber =
                      '${String.fromCharCode(65 + row)}${col + 1}';
                  final isSelected = selectedSeats.contains(seatNumber);

                  return SeatWidget(
                    seatNumber: seatNumber,
                    isAvailable: isAvailable,
                    isSelected: isSelected,
                    onTap: isAvailable ? () => _toggleSeat(row, col) : null,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: 20),
            if (selectedSeats.isNotEmpty) ...[
              const Text(
                'Selected Seats:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                selectedSeats.join(', '),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Total: \$${(selectedSeats.length * widget.showtime.price).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
            ],
            Center(
              child: ElevatedButton(
                onPressed: _bookTickets,
                child: const Text('Book Tickets'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
