import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:either_dart/either.dart';

abstract class CountryRepositore {
  Future<Either<Failure, List<CountryEnitity>>> searchForCountrys(String query);
  Future<void> setCountry(CountryEnitity location);
}
