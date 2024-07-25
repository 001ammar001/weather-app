import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/wether/domin/entites/weather_entity.dart';
import 'package:weather_app/features/wether/presentation/bloc/weather/weather_bloc.dart';
import 'package:weather_app/features/wether/presentation/pages/week_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaysNavigator extends StatelessWidget {
  final WeatherEntity weatherEntity;
  final CountryEnitity countryEnitity;

  const DaysNavigator({
    super.key,
    required this.weatherEntity,
    required this.countryEnitity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              if (BlocProvider.of<WeatherBloc>(context).index > 23) {
                BlocProvider.of<WeatherBloc>(context).add(
                  ChangeIndexEvent(
                      index: BlocProvider.of<WeatherBloc>(context).index - 23,
                      weatherEntity: weatherEntity),
                );
              }
            },
            child: Text(
              "Today",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: BlocProvider.of<WeatherBloc>(context).index < 23
                    ? const Color(0xFF313341)
                    : const Color(0xFFD6996B),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (BlocProvider.of<WeatherBloc>(context).index <= 23) {
                BlocProvider.of<WeatherBloc>(context).add(
                  ChangeIndexEvent(
                      index: BlocProvider.of<WeatherBloc>(context).index + 23,
                      weatherEntity: weatherEntity),
                );
              }
            },
            child: Text(
              "Tomorrow",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: BlocProvider.of<WeatherBloc>(context).index > 23
                    ? const Color(0xFF313341)
                    : const Color(0xFFD6996B),
              ),
            ),
          ),
          const Spacer(),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              BlocProvider.of<WeatherBloc>(context).add(
                GetWeekWeatherEvent(countryEnitity: countryEnitity),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WeekWeather(
                    countryEnitity: countryEnitity,
                  ),
                ),
              );
            },
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Next 7 Days",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFD6996B),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.0,
                  color: Color(0xFFD6996B),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
