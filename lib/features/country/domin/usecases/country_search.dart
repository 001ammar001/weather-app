import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/country/domin/repositores/country_repositore.dart';
import 'package:either_dart/either.dart';

class SearchForCountrysUseCase {
  final CountryRepositore repositore;

  SearchForCountrysUseCase({
    required this.repositore,
  });

  Future<Either<Failure, List<CountryEnitity>>> call(String query) async {
    return await repositore.searchForCountrys(query);
  }
}
