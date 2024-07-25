import 'dart:convert';
import 'package:weather_app/core/app_theme.dart';
import 'package:weather_app/core/injection_container.dart' as getit;
import 'package:weather_app/features/country/data/models/country_model.dart';
import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/country/presentation/bloc/country/country_bloc.dart';
import 'package:weather_app/features/country/presentation/pages/search_page.dart';
import 'package:weather_app/features/wether/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getit.init();
  final countryData = getit.sharedPreferences.getString("Location");
  CountryEnitity? countryEntity;
  if (countryData != null) {
    final countryJson = jsonDecode(countryData);
    countryEntity = CountryModel.fromJson(countryJson);
  }
  runApp(MyApp(countryEntity: countryEntity));
}

class MyApp extends StatelessWidget {
  final CountryEnitity? countryEntity;
  const MyApp({super.key, required this.countryEntity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getit.sl<CountryBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: countryEntity != null
            ? MainPage(
                countryEnitity: countryEntity!,
              )
            : const SearchPage(),
      ),
    );
  }
}
