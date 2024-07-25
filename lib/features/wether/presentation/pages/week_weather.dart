import 'package:weather_app/core/widgets/gridient_scaffold.dart';
import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/wether/presentation/bloc/week/week_bloc.dart';
import 'package:weather_app/features/wether/presentation/widgets/week_widgets/day_weather_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/injection_container.dart' as getit;

class WeekWeather extends StatelessWidget {
  final CountryEnitity countryEnitity;
  const WeekWeather({super.key, required this.countryEnitity});

  @override
  Widget build(BuildContext context) {
    final List<String> days = [
      "Monday",
      "Tuesday",
      "Wedensday",
      "Thirsday",
      "Friday",
      "Saturday",
      "Sunday",
    ];

    return BlocProvider(
      create: (_) => getit.sl<WeekBloc>()
        ..add(
          GetWeekWeatherEvent(countryEnitity: countryEnitity),
        ),
      child: GradientScaffold(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Next 7 Days",
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<WeekBloc, WeekStates>(
              builder: (context, state) {
                if (state is WeekFinishLoadingState) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return expansion(
                        days[index],
                        state.weekWeather.codes[index],
                        state.weekWeather.temperatures[index].toString(),
                        state.weekWeather.rains[index].toString(),
                        state.weekWeather.winds[index].toString(),
                        state.weekWeather.humidty[index].toString(),
                      );
                    },
                    itemCount: 7,
                  );
                } else if (state is WeekLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget expansion(
  String day,
  int code,
  String temprature,
  String rain,
  String wind,
  String humidity,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(12),
        collapsedBackgroundColor: const Color.fromARGB(94, 255, 255, 255),
        backgroundColor: const Color(0xB3FFFFFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          day,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        trailing: DayWeatherTile(
          day: day,
          code: code,
          temprature: temprature,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/images/umbrella.png",
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                  Text("${rain}CM")
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                children: [
                  Image.asset(
                    "assets/images/wind.png",
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                  Text("${wind}km/h"),
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                children: [
                  Image.asset(
                    "assets/images/water.png",
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                  Text("$humidity%")
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}
