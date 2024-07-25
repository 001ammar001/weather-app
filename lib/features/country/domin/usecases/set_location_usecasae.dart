import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/country/domin/repositores/country_repositore.dart';

class SetLocationUseCase {
  final CountryRepositore repositore;

  SetLocationUseCase({required this.repositore});

  Future<void> call(CountryEnitity location) async {
    return await repositore.setCountry(location);
  }
}
