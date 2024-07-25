import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final List<dynamic> temperatures;
  final List<dynamic> codes;
  final List<dynamic> rains;
  final List<dynamic> humidty;
  final List<dynamic> winds;

  const WeatherEntity(
      {required this.temperatures,
      required this.codes,
      required this.rains,
      required this.humidty,
      required this.winds});

  @override
  List<Object?> get props => [
        temperatures,
        codes,
        rains,
        humidty,
        winds,
      ];
}
