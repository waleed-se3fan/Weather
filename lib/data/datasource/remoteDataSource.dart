import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weather/data/models/weather.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeather(lat, lon);
  Future<WeatherModel> getWeatherbyCity(city);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  @override
  Future<WeatherModel> getWeather(lat, lon) async {
    String apiToken = 'd4194c8c732203fca9bc434b49de3b29';

    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiToken&units=metric';
    Uri uri = Uri.parse(url);
    Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var body = response.body;
      var data = jsonDecode(body);
      print(data);
      WeatherModel weather = WeatherModel.fromJson(data);
      return weather;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Future<WeatherModel> getWeatherbyCity(city) async {
    String api =
        'https://api.openweathermap.org/data/2.5/weather?q=$city,EG&appid=d4194c8c732203fca9bc434b49de3b29&units=metric';

    var uri = Uri.parse(api);
    Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      WeatherModel weather = WeatherModel.fromJson(data);
      return weather;
    } else {
      throw Exception('Error');
    }
  }
}
