import './weatherAPIClient.dart';
import '../models/weather.dart';
import 'dart:async';
import 'package:meta/meta.dart';

class WeatherRepository {
  final WeatherAPIClient weatherAPIClient;

  WeatherRepository({required this.weatherAPIClient})
      : assert(weatherAPIClient != null);
  Future<Weather> getWeather(String city) {
    return weatherAPIClient.getWeather(city);
  }
}
