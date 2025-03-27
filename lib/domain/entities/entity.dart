class WeatherEntity {
  String description;
  double temp;
  String city_name;
  String country;
  String main;
  double temp_min;
  double temp_max;
  double sunrise;
  double sunset;

  WeatherEntity({
    required this.description,
    required this.temp,
    required this.city_name,
    required this.country,
    required this.main,
    required this.temp_min,
    required this.temp_max,
    required this.sunrise,
    required this.sunset,
  });
}
