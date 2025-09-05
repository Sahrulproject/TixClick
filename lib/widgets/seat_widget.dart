import 'package:flutter/material.dart';

class SeatWidget extends StatelessWidget {
  final String seatNumber;
  final bool isAvailable;
  final bool isSelected;
  final VoidCallback? onTap;

  const SeatWidget({
    Key? key,
    required this.seatNumber,
    required this.isAvailable,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0F1B2B)
              : isAvailable
              ? Colors.green
              : Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            seatNumber,
            style: TextStyle(
              color: isSelected || !isAvailable ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
