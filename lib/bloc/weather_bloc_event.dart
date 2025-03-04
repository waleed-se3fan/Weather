part of 'weather_bloc_bloc.dart';

abstract class WeatherBlocEvent {}

class GetLocationEvent extends WeatherBlocEvent {}

class FetchWeather extends WeatherBlocEvent {}
