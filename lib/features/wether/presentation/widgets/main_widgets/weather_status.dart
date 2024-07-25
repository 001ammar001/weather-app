import 'package:flutter/material.dart';

class WeatherStatus extends StatelessWidget {
  final String image;
  final String text;
  final String value;

  const WeatherStatus({
    super.key,
    required this.image,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 11),
      height: MediaQuery.sizeOf(context).height * 0.08,
      decoration: BoxDecoration(
        color: const Color.fromARGB(94, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.asset(image, fit: BoxFit.cover),
          Text(text),
          const Spacer(),
          Text(value),
        ],
      ),
    );
  }
}
