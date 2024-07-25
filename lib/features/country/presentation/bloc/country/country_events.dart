part of 'country_bloc.dart';

abstract class CountryEvent extends Equatable {}

class SearchForCountryEvent extends CountryEvent {
  final String query;
  SearchForCountryEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

class SetLocationEvent extends CountryEvent {
  final CountryEnitity country;
  SetLocationEvent({required this.country});

  @override
  List<Object?> get props => [country];
}

class GetLocationEvent extends CountryEvent {
  @override
  List<Object?> get props => [];
}
