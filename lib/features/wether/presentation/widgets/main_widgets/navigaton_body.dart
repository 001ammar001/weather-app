import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/wether/domin/entites/weather_entity.dart';
import 'package:weather_app/features/wether/presentation/widgets/main_widgets/days_navigator.dart';
import 'package:weather_app/features/wether/presentation/widgets/main_widgets/hours_list.dart';
import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  final ScrollController scrollController;
  final WeatherEntity weatherEntity;
  final CountryEnitity countryEnitity;

  const Navigation(
      {super.key,
      required this.scrollController,
      required this.weatherEntity,
      required this.countryEnitity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DaysNavigator(
          weatherEntity: weatherEntity,
          countryEnitity: countryEnitity,
        ),
        HoursList(
          scrollController: scrollController,
          weatherEntity: weatherEntity,
        )
      ],
    );
  }
}
