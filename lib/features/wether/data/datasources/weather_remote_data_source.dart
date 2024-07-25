import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/wether/data/models/weather_model.dart';
import 'package:dio/dio.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getTodayWeather(CountryEnitity country);
  Future<WeatherModel> getWeekWeather(CountryEnitity country);
}

class WeatherDioRemoteDataSource extends WeatherRemoteDataSource {
  final Dio dio;

  WeatherDioRemoteDataSource({required this.dio});

  @override
  Future<WeatherModel> getTodayWeather(CountryEnitity country) async {
    final response = await dio.get(
      "https://api.open-meteo.com/v1/forecast",
      queryParameters: {
        "latitude": country.latitude,
        "longitude": country.longitude,
        "hourly":
            "temperature_2m,weather_code,rain,relative_humidity_2m,wind_speed_10m",
        "forecast_days": 2,
      },
    );
    if (response.statusCode == 200) {
      final data = response.data["hourly"];
      final x = WeatherModel.fromJsonToday(data);
      return x;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<WeatherModel> getWeekWeather(CountryEnitity country) async {
    DateTime now = DateTime.now();
    DateTime next = now.add(const Duration(days: 6));
    String nowFormated =
        "${now.year}-${now.month.toString().padLeft(2, "0")}-${now.day.toString().padLeft(2, "0")}";
    String nextFormated =
        "${next.year}-${next.month.toString().padLeft(2, "0")}-${next.day.toString().padLeft(2, "0")}";

    final response = await dio.get(
      "https://api.open-meteo.com/v1/forecast",
      queryParameters: {
        "latitude": country.latitude,
        "longitude": country.longitude,
        "daily":
            "temperature_2m_max,rain_sum,weather_code,wind_speed_10m_max,relative_humidity_2m_max",
        "start_date": nowFormated,
        "end_date": nextFormated
      },
    );
    if (response.statusCode == 200) {
      final data = response.data["daily"];
      return WeatherModel.fromJsonWeek(data);
    } else {
      throw ServerException();
    }
  }
}
