import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weather/core/utils/snackbar.dart';
import 'package:weather/data/datasource/remoteDataSource.dart';
import 'package:weather/data/models/weather.dart';
import 'package:weather/data/repositories/get_weather.dart';
import 'package:weather/domain/entities/entity.dart';
import 'package:weather/domain/repositiries/weatherrepo.dart';
import 'package:weather/domain/usecases/useCase.dart';
part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<GetLocationEvent>((event, emit) {
      getlocation();
    });
    on<GetWeatherByCityEvent>((event, emit) {
      searchByCity(event.cityName, event.context);
    });
  }

  final getWeatherUsecase =
      GetWeatherUseCase(WeatherRepositoryImpl(WeatherRemoteDataSourceImpl()));

  getlocation() async {
    emit(LocationBlocLoading());
    try {
      Position position = await Geolocator.getCurrentPosition();
      String lat = position.latitude.toString();
      String lon = position.longitude.toString();
      emit(LocationBlocSucces(lat, lon));
      fetchWeather(lat, lon);
    } catch (e) {
      emit(LocationBlocFailure());
    }
  }

  Future fetchWeather(lat, lon) async {
    emit(WeatherBlocLoading());
    try {
      WeatherEntity weather = await getWeatherUsecase.call(lat, lon);
      emit(WeatherBlocSucces(weather));
    } catch (e) {}
  }

  static String weather_image(String weather) {
    if (weather == 'Clear') {
      return 'assets/7.png';
    } else if (weather == 'Clouds') {
      return 'assets/8.png';
    } else if (weather == 'Rain') {
      return 'assets/3.png';
    } else if (weather == 'Thunderstorm') {
      return 'assets/1.png';
    } else if (weather == 'Snow') {
      return 'assets/5.png';
    } else {
      return 'assets/9.png';
    }
  }

  Future searchByCity(String city, context) async {
    emit(WeatherBlocLoading());
    try {
      final weather = await getWeatherUsecase.getWeatherbyCity(city);
      emit(WeatherBlocSucces(weather));
    } catch (e) {
      CustomSnackBar().showSnackBar(context);
      getlocation();
    }
  }
}
