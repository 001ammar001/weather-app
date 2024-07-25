part of 'weather_bloc.dart';

abstract class WeatherStates extends Equatable {}

class WeatherInitState extends WeatherStates {
  @override
  List<Object?> get props => [];
}

class WeatherLoadingState extends WeatherStates {
  @override
  List<Object?> get props => [];
}

class TodayWeatherFinishLoadingState extends WeatherStates {
  final WeatherEntity todayWeather;

  TodayWeatherFinishLoadingState({required this.todayWeather});

  @override
  List<Object?> get props => [todayWeather];
}

class WeatherFaildState extends WeatherStates {
  final String message;
  WeatherFaildState({required this.message});

  @override
  List<Object?> get props => [message];
}

class WeekWeatherFinishLoadingState extends WeatherStates {
  final WeatherEntity weekWeather;

  WeekWeatherFinishLoadingState({required this.weekWeather});

  @override
  List<Object?> get props => [weekWeather];
}
