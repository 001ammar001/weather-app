import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:flutter/material.dart';

class CountryDay extends StatelessWidget {
  final CountryEnitity countryEnitity;
  const CountryDay({super.key, required this.countryEnitity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.15,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${countryEnitity.country},\n${countryEnitity.name}",
              style: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w500,
                color: Color(0xFF313341),
              ),
            ),
            Text(
              "${getDay(DateTime.now().weekday)} ${DateTime.now().day}",
              style: const TextStyle(
                fontSize: 19,
                color: Color(0xFF9A938C),
              ),
            )
          ],
        ),
      ),
    );
  }
}

String getDay(int number) {
  switch (number) {
    case 1:
      return "Mon";
    case 2:
      return "Tue";
    case 3:
      return "Wed";
    case 4:
      return "Thu";
    case 5:
      return "Fri";
    case 6:
      return "Sat";
    case 7:
      return "Sun";
    default:
      return "ERR";
  }
}
