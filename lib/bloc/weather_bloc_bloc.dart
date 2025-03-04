import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weather/data/weather.dart';
part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<WeatherBlocEvent>((event, emit) {
      fetchWeather('0.0', '0.0');
    });
    on<GetLocationEvent>((event, emit) {
      getlocation();
    });
  }

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
    String api_token = 'd4194c8c732203fca9bc434b49de3b29';
    print(lat);
    print(lon);
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${api_token}&units=metric';
    Uri uri = Uri.parse(url);
    Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var body = response.body;
      var data = jsonDecode(body);
      print(data);
      WeatherModel weather = WeatherModel.fromJson(data);
      emit(WeatherBlocSucces(weather));
    } else {
      emit(WeatherBlocFailure());
      print('Failed to fetch data');
    }
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
}
