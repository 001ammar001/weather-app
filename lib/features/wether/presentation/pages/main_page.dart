import 'package:weather_app/core/widgets/gridient_scaffold.dart';
import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/wether/presentation/pages/main_body.dart';
import 'package:weather_app/features/country/presentation/pages/search_page.dart';
import 'package:weather_app/features/wether/presentation/bloc/weather/weather_bloc.dart';
import 'package:weather_app/core/injection_container.dart' as getit;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final CountryEnitity countryEnitity;

  const MainPage({super.key, required this.countryEnitity});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
              icon: Image.asset(
                "assets/images/search.png",
                fit: BoxFit.cover,
                height: 40,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/images/lines.png",
                  fit: BoxFit.cover,
                  height: 40,
                ),
              ),
            ],
          ),
          body: BlocProvider(
            create: (context) => getit.sl<WeatherBloc>()
              ..add(
                GetTodayWeatherEvent(countryEnitity: countryEnitity),
              ),
            child: MainBody(
              countryEnitity: countryEnitity,
            ),
          )),
    );
  }
}
