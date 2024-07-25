import 'dart:convert';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/wether/data/models/weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class WeatherLocalDataSource {
  Future cacheTodayWeather(WeatherModel weatherModel);
  Future cacheWeekWeather(WeatherModel weatherModel);
  Future<WeatherModel> getTodayWeather();
  Future<WeatherModel> getWeekWeather();
}

class WeatherSharedPrefrencesLocalDataSource extends WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherSharedPrefrencesLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> cacheTodayWeather(WeatherModel weatherModel) {
    String data = jsonEncode(weatherModel.toString());
    sharedPreferences.setString("TodayWeather", data);
    return Future.value();
  }

  @override
  Future cacheWeekWeather(WeatherModel weatherModel) {
    String data = jsonEncode(weatherModel.toString());
    sharedPreferences.setString("WeekWeather", data);
    return Future.value();
  }

  @override
  Future<WeatherModel> getTodayWeather() {
    String? data = sharedPreferences.getString("TodayWeather");
    return getWeather(data);
  }

  @override
  Future<WeatherModel> getWeekWeather() {
    String? data = sharedPreferences.getString("WeekWeather");
    return getWeather(data);
  }

  Future<WeatherModel> getWeather(String? data) {
    if (data != null) {
      final json = jsonDecode(data);
      return Future.value(WeatherModel.fromJsonToday(json));
    } else {
      throw EmptyCacheException();
    }
  }
}
