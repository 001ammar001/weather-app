import 'dart:convert';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/country/data/models/country_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CountryLocalDataSource {
  Future<List<CountryModel>> getCachedCountrys();
  Future cacheCountrys(List<CountryModel> countrys);
  Future cacheCountry(CountryModel country);
}

class CountrySharedPreferencesLocalDataSource extends CountryLocalDataSource {
  final SharedPreferences sharedPreferences;

  CountrySharedPreferencesLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> cacheCountrys(List<CountryModel> countrys) {
    List jsonData = countrys.map((country) => country.toJson()).toList();
    String data = jsonEncode(jsonData);
    sharedPreferences.setString("CACHED_COUNTRY", data);
    return Future.value();
  }

  @override
  Future<List<CountryModel>> getCachedCountrys() {
    String? data = sharedPreferences.getString("CACHED_COUNTRY");
    if (data != null) {
      List jsonData = jsonDecode(data);
      List<CountryModel> countrys =
          jsonData.map((e) => CountryModel.fromJson(e)).toList();
      return Future.value(countrys);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future cacheCountry(CountryModel country) {
    sharedPreferences.setString("Location", jsonEncode(country.toJson()));
    return Future.value();
  }
}
