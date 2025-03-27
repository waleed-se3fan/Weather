import 'package:weather/domain/entities/entity.dart';

abstract class WeatherRepositories {
  Future<WeatherEntity> getWeather(lat, lon);
  Future<WeatherEntity> getWeatherbyCity(cityName);
}
