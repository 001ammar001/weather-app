import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/network/network_checker.dart';
import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/wether/data/datasources/weather_local_data_source.dart';
import 'package:weather_app/features/wether/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/wether/domin/entites/weather_entity.dart';
import 'package:weather_app/features/wether/domin/repositores/weather_repositore.dart';
import 'package:either_dart/either.dart';

class WeatherRepositoreImp extends WeatherRepositore {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkChecker networkChecker;

  WeatherRepositoreImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkChecker,
  });

  @override
  Future<Either<Failure, WeatherEntity>> getTodayWeather(
      CountryEnitity countryEnitity) async {
    if (await networkChecker.getConnectionStatus()) {
      try {
        final weather = await remoteDataSource.getTodayWeather(countryEnitity);
        localDataSource.cacheTodayWeather(weather);
        return Right(weather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final weather = await localDataSource.getTodayWeather();
        return Right(weather);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, WeatherEntity>> getWeekWeather(
      CountryEnitity countryEnitity) async {
    if (await networkChecker.getConnectionStatus()) {
      try {
        final weather = await remoteDataSource.getWeekWeather(countryEnitity);
        localDataSource.cacheWeekWeather(weather);
        return Right(weather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final weather = await localDataSource.getWeekWeather();
        return Right(weather);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
