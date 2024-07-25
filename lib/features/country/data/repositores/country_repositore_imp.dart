import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/network/network_checker.dart';
import 'package:weather_app/features/country/data/datasouces/country_local_data_source.dart';
import 'package:weather_app/features/country/data/datasouces/country_reomte_data_source.dart';
import 'package:weather_app/features/country/data/models/country_model.dart';
import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/country/domin/repositores/country_repositore.dart';
import 'package:either_dart/either.dart';

class CountryRepositoreImp extends CountryRepositore {
  final CountryReomteDataSource reomteDataSource;
  final CountryLocalDataSource localDataSource;
  final NetworkChecker networkChecker;

  CountryRepositoreImp({
    required this.reomteDataSource,
    required this.localDataSource,
    required this.networkChecker,
  });

  @override
  Future<Either<Failure, List<CountryEnitity>>> searchForCountrys(
      String query) async {
    if (await networkChecker.getConnectionStatus()) {
      try {
        final countrys = await reomteDataSource.searchForCountry(query);
        localDataSource.cacheCountrys(countrys);
        return Right(countrys);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final countrys = await localDataSource.getCachedCountrys();
        return Right(countrys);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<void> setCountry(CountryEnitity location) async {
    CountryModel country = CountryModel(
        name: location.name,
        latitude: location.latitude,
        longitude: location.longitude,
        countryCode: location.countryCode,
        timezone: location.timezone,
        country: location.country);

    localDataSource.cacheCountry(country);
  }
}
