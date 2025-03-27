import 'package:weather/data/datasource/remoteDataSource.dart';
import 'package:weather/domain/entities/entity.dart';
import 'package:weather/domain/repositiries/weatherrepo.dart';

class WeatherRepositoryImpl implements WeatherRepositories {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl(this.weatherRemoteDataSource);

  @override
  Future<WeatherEntity> getWeather(lat, lon) async {
    final weatherModel = await weatherRemoteDataSource.getWeather(lat, lon);
    return weatherModel.toEntity();
  }

  @override
  Future<WeatherEntity> getWeatherbyCity(cityName) async {
    final weatherModel =
        await weatherRemoteDataSource.getWeatherbyCity(cityName);
    return weatherModel.toEntity();
  }
}
