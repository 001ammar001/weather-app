import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/wether/domin/entites/weather_entity.dart';
import 'package:weather_app/features/wether/domin/repositores/weather_repositore.dart';
import 'package:either_dart/either.dart';

class GetTodayWeatherUseCase {
  final WeatherRepositore repositore;

  const GetTodayWeatherUseCase({
    required this.repositore,
  });

  Future<Either<Failure, WeatherEntity>> call(
      CountryEnitity countryEnitity) async {
    return await repositore.getTodayWeather(countryEnitity);
  }
}
