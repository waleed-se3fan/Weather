import 'package:weather/domain/entities/entity.dart';
import 'package:weather/domain/repositiries/weatherrepo.dart';

class GetWeatherUseCase {
  final WeatherRepositories weatherRepo;
  GetWeatherUseCase(this.weatherRepo);
  Future<WeatherEntity> call(lat, lon) async {
    return await weatherRepo.getWeather(lat, lon);
  }

  Future<WeatherEntity> getWeatherbyCity(cityName) async {
    return await weatherRepo.getWeatherbyCity(cityName);
  }
}
