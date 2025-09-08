// utils/image_utils.dart
import 'dart:convert';
import 'package:flutter/material.dart';

class ImageUtils {
  static Image imageFromBase64String(String base64String) {
    try {
      // Hapus prefix jika ada (misal: "data:image/png;base64,")
      final String base64Data = base64String.contains(',')
          ? base64String.split(',').last
          : base64String;

      return Image.memory(
        base64Decode(base64Data),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error);
        },
      );
    } catch (e) {
      return Image.asset(
        'assets/images/placeholder.png', // Pastikan ada placeholder di assets
        fit: BoxFit.cover,
      );
    }
  }
}
