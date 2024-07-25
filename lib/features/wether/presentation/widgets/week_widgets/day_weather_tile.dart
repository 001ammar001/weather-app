import 'package:weather_app/core/functions/map_code_to_weather.dart';
import 'package:flutter/material.dart';

class DayWeatherTile extends StatelessWidget {
  final String day;
  final String temprature;
  final int code;
  const DayWeatherTile({
    super.key,
    required this.day,
    required this.temprature,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          temprature,
          style: const TextStyle(fontSize: 20),
        ),
        Image.asset(
          "assets/images/${mapCodeToWearher(code)}.png",
          fit: BoxFit.cover,
          height: 64,
          width: 64,
        ),
      ],
    );
  }
}
