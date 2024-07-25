part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {}

class GetTodayWeatherEvent extends WeatherEvent {
  final CountryEnitity countryEnitity;

  GetTodayWeatherEvent({required this.countryEnitity});
  @override
  List<Object?> get props => [countryEnitity];
}

class GetWeekWeatherEvent extends WeatherEvent {
  final CountryEnitity countryEnitity;

  GetWeekWeatherEvent({required this.countryEnitity});
  @override
  List<Object?> get props => [countryEnitity];
}

class ChangeIndexEvent extends WeatherEvent {
  final int index;
  final WeatherEntity weatherEntity;

  ChangeIndexEvent({required this.index, required this.weatherEntity});
  @override
  List<Object?> get props => [index, weatherEntity];
}

class ChangeWeekIndexEvent extends WeatherEvent {
  final int index;
  final WeatherEntity weatherEntity;

  ChangeWeekIndexEvent({required this.index, required this.weatherEntity});
  @override
  List<Object?> get props => [index, weatherEntity];
}
