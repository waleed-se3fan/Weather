part of 'weather_bloc_bloc.dart';

abstract class WeatherBlocEvent {}

class GetLocationEvent extends WeatherBlocEvent {}

class FetchWeather extends WeatherBlocEvent {}

class GetWeatherByCityEvent extends WeatherBlocEvent {
  final String cityName;
  final BuildContext context;
  GetWeatherByCityEvent(this.cityName, this.context);
}
