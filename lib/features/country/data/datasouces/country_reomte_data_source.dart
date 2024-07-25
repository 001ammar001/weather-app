import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/country/data/models/country_model.dart';
import 'package:dio/dio.dart';

abstract class CountryReomteDataSource {
  Future<List<CountryModel>> searchForCountry(String query);
}

class CountryDioRemoteDataSource extends CountryReomteDataSource {
  final Dio dio;
  CountryDioRemoteDataSource({required this.dio});
  @override
  Future<List<CountryModel>> searchForCountry(String query) async {
    final response = await dio.get(
      "https://geocoding-api.open-meteo.com/v1/search",
      queryParameters: {
        "name": query,
        "count": 10,
        "language": "en",
        "format": "json",
      },
    );
    if (response.statusCode == 200) {
      List? data = response.data["results"];
      if (data != null) {
        List<CountryModel> countrys =
            data.map((x) => CountryModel.fromJson(x)).toList();
        return countrys;
      }
      return [];
    } else {
      throw ServerException();
    }
  }
}
