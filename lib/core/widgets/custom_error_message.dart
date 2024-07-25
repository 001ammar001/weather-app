import 'package:flutter/material.dart';

SnackBar customErrorMessage(String message) {
  return SnackBar(
    backgroundColor: const Color(0xFFF39876),
    content: Text(
      "Country seted successfully to $message",
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
