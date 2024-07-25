import 'package:weather_app/core/functions/map_code_to_weather.dart';
import 'package:weather_app/features/wether/domin/entites/weather_entity.dart';
import 'package:weather_app/features/wether/presentation/bloc/weather/weather_bloc.dart';
import 'package:weather_app/features/wether/presentation/widgets/main_widgets/hourly_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HoursList extends StatelessWidget {
  final WeatherEntity weatherEntity;
  final ScrollController scrollController;

  const HoursList({
    super.key,
    required this.scrollController,
    required this.weatherEntity,
  });

  @override
  Widget build(BuildContext context) {
    int index = BlocProvider.of<WeatherBloc>(context).index > 23 ? 23 : 0;
    return RawScrollbar(
      interactive: true,
      thumbVisibility: true,
      trackVisibility: true,
      controller: scrollController,
      thumbColor: const Color(0xFF313341),
      trackColor: const Color(0xFFE2A272),
      mainAxisMargin: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollbarOrientation: ScrollbarOrientation.top,
      thickness: 3,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.18,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          itemCount: 24,
          itemBuilder: (context, idx) => InkWell(
            onTap: () {
              BlocProvider.of<WeatherBloc>(context).add(
                ChangeIndexEvent(
                  index: index + idx,
                  weatherEntity: weatherEntity,
                ),
              );
            },
            borderRadius: BorderRadius.circular(
              MediaQuery.sizeOf(context).height * 0.08,
            ),
            child: HourlyWeather(
              hour: "${idx.toString().padLeft(2, '0')}:00",
              temprature: weatherEntity.temperatures[index + idx].toString(),
              image: mapCodeToWearher(weatherEntity.codes[index + idx]),
              color: idx == BlocProvider.of<WeatherBloc>(context).index ||
                      idx == BlocProvider.of<WeatherBloc>(context).index - 23
                  ? const Color(0xFFFFFFFF)
                  : const Color(0xB3FFFFFF),
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(
            width: 5,
          ),
        ),
      ),
    );
  }
}
