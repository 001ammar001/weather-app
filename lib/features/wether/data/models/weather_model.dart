import 'package:weather_app/features/wether/domin/entites/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel(
      {required super.temperatures,
      required super.codes,
      required super.rains,
      required super.humidty,
      required super.winds});

  factory WeatherModel.fromJsonToday(Map<String, dynamic> json) {
    return WeatherModel(
      temperatures: json["temperature_2m"],
      codes: json["weather_code"],
      rains: json["rain"],
      humidty: json["relative_humidity_2m"],
      winds: json["wind_speed_10m"],
    );
  }

  factory WeatherModel.fromJsonWeek(Map<String, dynamic> json) {
    return WeatherModel(
      temperatures: json["temperature_2m_max"],
      codes: json["weather_code"],
      rains: json["rain_sum"],
      humidty: json["relative_humidity_2m_max"],
      winds: json["wind_speed_10m_max"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "temperature_2m": temperatures,
      "weather_code": codes,
      "rain": rains,
      "relative_humidity_2m": humidty,
      "wind_speed_10m": winds,
    };
  }
}
