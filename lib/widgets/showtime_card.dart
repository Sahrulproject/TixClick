import 'package:flutter/material.dart';
import '../models/showtime_model.dart';

class ShowtimeCard extends StatelessWidget {
  final Showtime showtime;
  final VoidCallback onBook;

  const ShowtimeCard({Key? key, required this.showtime, required this.onBook})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theater: ${showtime.theater}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Time: ${showtime.dateTime.hour}:${showtime.dateTime.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Price: \$${showtime.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onBook,
                child: const Text('Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
