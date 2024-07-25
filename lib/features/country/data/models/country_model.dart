import 'package:weather_app/features/country/domin/entites/countrys.dart';

class CountryModel extends CountryEnitity {
  const CountryModel({
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.countryCode,
    required super.timezone,
    required super.country,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json["name"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      countryCode: json["country_code"],
      timezone: json["timezone"],
      country: json["country"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'country_code': countryCode,
      'timezone': timezone,
      'country': country,
    };
  }
}
