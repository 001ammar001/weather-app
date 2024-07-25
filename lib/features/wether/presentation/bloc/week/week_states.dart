part of 'week_bloc.dart';

abstract class WeekStates extends Equatable {}

class WeekInitState extends WeekStates {
  @override
  List<Object?> get props => [];
}

class WeekLoadingState extends WeekStates {
  @override
  List<Object?> get props => [];
}

class WeekFaildState extends WeekStates {
  final String message;
  WeekFaildState({required this.message});

  @override
  List<Object?> get props => [message];
}

class WeekFinishLoadingState extends WeekStates {
  final WeatherEntity weekWeather;

  WeekFinishLoadingState({required this.weekWeather});

  @override
  List<Object?> get props => [weekWeather];
}
