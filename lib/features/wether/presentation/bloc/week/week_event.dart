part of 'week_bloc.dart';

abstract class WeekEvent extends Equatable {}

class GetWeekWeatherEvent extends WeekEvent {
  final CountryEnitity countryEnitity;

  GetWeekWeatherEvent({required this.countryEnitity});
  @override
  List<Object?> get props => [countryEnitity];
}
