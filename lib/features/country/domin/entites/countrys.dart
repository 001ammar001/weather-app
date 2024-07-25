import 'package:equatable/equatable.dart';

class CountryEnitity extends Equatable {
  final String name;
  final double latitude;
  final double longitude;
  final String countryCode;
  final String timezone;
  final String country;

  const CountryEnitity({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.countryCode,
    required this.timezone,
    required this.country,
  });

  @override
  List<Object?> get props => [
        name,
        latitude,
        longitude,
        countryCode,
        timezone,
        country,
      ];
}
