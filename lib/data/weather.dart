class WeatherModel {
  String description;
  double temp;
  String city_name;
  String country;
  String main;
  double temp_min;
  double temp_max;
  double sunrise;
  double sunset;
  WeatherModel(this.description, this.temp, this.city_name, this.country,
      this.main, this.temp_min, this.temp_max, this.sunrise, this.sunset);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        json['weather'][0]['description'] ?? '',
        json['main']['temp'] ?? 0,
        json['name'] ?? '',
        json['sys']['country'] ?? '',
        json['weather'][0]['main'] ?? '',
        json['main']['temp_min'] ?? 0,
        json['main']['temp_max'] ?? 0,
        json['sys']['sunrise'] ?? 0,
        json['sys']['sunset'] ?? 0);
  }
}
