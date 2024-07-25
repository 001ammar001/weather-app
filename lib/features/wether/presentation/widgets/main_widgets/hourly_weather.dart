import 'package:flutter/material.dart';

class HourlyWeather extends StatelessWidget {
  final String hour;
  final String image;
  final String temprature;
  final Color color;
  const HourlyWeather({
    super.key,
    required this.hour,
    required this.image,
    required this.temprature,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: MediaQuery.sizeOf(context).height * 0.12,
      width: MediaQuery.sizeOf(context).height * 0.08,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          MediaQuery.sizeOf(context).height * 0.08,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            hour,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Image.asset(
            "assets/images/$image.png",
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
          Text(
            "$temprature\u00b0",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
