import 'package:weather_app/features/wether/presentation/widgets/main_widgets/weather_status.dart';
import 'package:flutter/material.dart';

class WeatherStack extends StatelessWidget {
  final dynamic rain;
  final dynamic wind;
  final dynamic humidity;
  const WeatherStack({
    super.key,
    required this.rain,
    required this.wind,
    required this.humidity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WeatherStatus(
            image: "assets/images/umbrella.png",
            text: "RainFall",
            value: "${rain.toString()}CM",
          ),
          WeatherStatus(
            image: "assets/images/wind.png",
            text: "Wind",
            value: "${wind.toString()}km/h",
          ),
          WeatherStatus(
            image: "assets/images/water.png",
            text: "Humidity",
            value: "${humidity.toString()}%",
          ),
        ],
      ),
    );
  }
}
