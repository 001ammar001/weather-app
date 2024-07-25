import 'package:weather_app/core/network/network_checker.dart';
import 'package:weather_app/features/country/data/datasouces/country_local_data_source.dart';
import 'package:weather_app/features/country/data/datasouces/country_reomte_data_source.dart';
import 'package:weather_app/features/country/data/repositores/country_repositore_imp.dart';
import 'package:weather_app/features/country/domin/repositores/country_repositore.dart';
import 'package:weather_app/features/country/domin/usecases/country_search.dart';
import 'package:weather_app/features/country/domin/usecases/set_location_usecasae.dart';
import 'package:weather_app/features/country/presentation/bloc/country/country_bloc.dart';
import 'package:weather_app/features/wether/data/datasources/weather_local_data_source.dart';
import 'package:weather_app/features/wether/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/wether/data/repositores/weather_repostire_imp.dart';
import 'package:weather_app/features/wether/domin/repositores/weather_repositore.dart';
import 'package:weather_app/features/wether/domin/usecases/get_today_weather_usecase.dart';
import 'package:weather_app/features/wether/domin/usecases/get_week_weather.dart';
import 'package:weather_app/features/wether/presentation/bloc/weather/weather_bloc.dart';
import 'package:weather_app/features/wether/presentation/bloc/week/week_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
late SharedPreferences sharedPreferences;

Future<void> init() async {
  sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //! Network
  sl.registerLazySingleton<NetworkChecker>(
      () => ConnectivityNetworkCkecker(connectivity: sl()));

  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      ),
    ),
  );
  sl.registerLazySingleton(() => Connectivity());

  //! Countrys
  sl.registerFactory(() => CountryBloc(
        searchForCountrysUseCase: sl(),
        setLocationUseCase: sl(),
      ));

  // Usecases
  sl.registerLazySingleton(() => SearchForCountrysUseCase(repositore: sl()));
  sl.registerLazySingleton(() => SetLocationUseCase(repositore: sl()));

  // Repositoreys
  sl.registerLazySingleton<CountryRepositore>(
    () => CountryRepositoreImp(
      localDataSource: sl(),
      networkChecker: sl(),
      reomteDataSource: sl(),
    ),
  );

  // RemoteDataSources
  sl.registerLazySingleton<CountryReomteDataSource>(
      () => CountryDioRemoteDataSource(dio: sl()));

  // LoalDataSources
  sl.registerLazySingleton<CountryLocalDataSource>(
      () => CountrySharedPreferencesLocalDataSource(sharedPreferences: sl()));

  //! Weather
  sl.registerFactory(() => WeatherBloc(
        getTodayWeatherUseCase: sl(),
      ));

  sl.registerFactory(() => WeekBloc(
        getWeekWeatherUseCase: sl(),
      ));

  // Weather Usecases
  sl.registerLazySingleton(() => GetTodayWeatherUseCase(repositore: sl()));
  sl.registerLazySingleton(() => GetWeekWeatherUseCase(repositore: sl()));

  // Weather Repositores
  sl.registerLazySingleton<WeatherRepositore>(() => WeatherRepositoreImp(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkChecker: sl(),
      ));

  // Weather RemoteDataSoureces
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherDioRemoteDataSource(dio: sl()));

  // LoalDataSources
  sl.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherSharedPrefrencesLocalDataSource(sharedPreferences: sl()));
}
