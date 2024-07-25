import 'package:weather_app/core/functions/map_code_to_weather.dart';
import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/wether/presentation/bloc/weather/weather_bloc.dart';
import 'package:weather_app/features/wether/presentation/widgets/main_widgets/country_day.dart';
import 'package:weather_app/features/wether/presentation/widgets/main_widgets/current_wheather.dart';
import 'package:weather_app/features/wether/presentation/widgets/main_widgets/navigaton_body.dart';
import 'package:weather_app/features/wether/presentation/widgets/main_widgets/weather_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBody extends StatelessWidget {
  final CountryEnitity countryEnitity;

  const MainBody({super.key, required this.countryEnitity});

  @override
  Widget build(BuildContext context) {
    int index = BlocProvider.of<WeatherBloc>(context).index;
    ScrollController scrollController = ScrollController(
      initialScrollOffset: MediaQuery.sizeOf(context).height * 0.08 * index,
    );

    return BlocConsumer<WeatherBloc, WeatherStates>(
      listener: (context, state) {
        if (state is TodayWeatherFinishLoadingState) {
          index = BlocProvider.of<WeatherBloc>(context).index;
        }
      },
      builder: (context, state) {
        if (state is WeatherInitState || state is WeatherLoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        } else if (state is TodayWeatherFinishLoadingState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CountryDay(countryEnitity: countryEnitity),
                CurrentWeather(
                  image:
                      "assets/images/${mapCodeToWearher(state.todayWeather.codes[index])}.png",
                  status: mapCodeToWearher(state.todayWeather.codes[index])
                      .replaceAll("_", " "),
                  temprature: state.todayWeather.temperatures[index],
                ),
                WeatherStack(
                  rain: state.todayWeather.rains[index],
                  wind: state.todayWeather.winds[index],
                  humidity: state.todayWeather.humidty[index],
                ),
                Navigation(
                  scrollController: scrollController,
                  weatherEntity: state.todayWeather,
                  countryEnitity: countryEnitity,
                )
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
