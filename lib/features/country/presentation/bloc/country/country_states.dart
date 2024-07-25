part of 'country_bloc.dart';

abstract class CountryStates extends Equatable {}

class CountryInitState extends CountryStates {
  @override
  List<Object?> get props => [];
}

class CountryLoadingSearchState extends CountryStates {
  @override
  List<Object?> get props => [];
}

class CountryFinishSearchingState extends CountryStates {
  final List<CountryEnitity> countrys;
  CountryFinishSearchingState({required this.countrys});

  @override
  List<Object?> get props => [countrys];
}

class CountrySearchFaildState extends CountryStates {
  final String message;
  CountrySearchFaildState({required this.message});

  @override
  List<Object?> get props => [message];
}

class SetLocationCountySuccessState extends CountryStates {
  final CountryEnitity country;

  SetLocationCountySuccessState({required this.country});
  @override
  List<Object?> get props => [country];
}
