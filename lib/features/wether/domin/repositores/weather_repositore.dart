import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/wether/domin/entites/weather_entity.dart';
import 'package:either_dart/either.dart';

abstract class WeatherRepositore {
  Future<Either<Failure, WeatherEntity>> getTodayWeather(
      CountryEnitity countryEnitity);
  Future<Either<Failure, WeatherEntity>> getWeekWeather(
      CountryEnitity countryEnitity);
}
