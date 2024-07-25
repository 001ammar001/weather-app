import 'package:flutter/material.dart';

class CurrentWeather extends StatelessWidget {
  final String image;
  final String status;
  final double temprature;

  const CurrentWeather({
    super.key,
    required this.image,
    required this.temprature,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.185,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: MediaQuery.sizeOf(context).height * 0.185,
            height: MediaQuery.sizeOf(context).height * 0.185,
            fit: BoxFit.fill,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$temprature\u00b0",
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                status,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
