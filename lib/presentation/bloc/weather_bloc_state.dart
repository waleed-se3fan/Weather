part of 'weather_bloc_bloc.dart';

abstract class WeatherBlocState {}

final class WeatherBlocInitial extends WeatherBlocState {}

class WeatherBlocLoading extends WeatherBlocState {}

class WeatherBlocFailure extends WeatherBlocState {}

class WeatherBlocSucces extends WeatherBlocState {
  final WeatherEntity weather;
  WeatherBlocSucces(this.weather);
}

class LocationBlocLoading extends WeatherBlocState {}

class LocationBlocFailure extends WeatherBlocState {}

class LocationBlocSucces extends WeatherBlocState {
  final String lat;
  final String lon;
  LocationBlocSucces(this.lat, this.lon);
}
