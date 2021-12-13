//lib/weather_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'weather.dart';

class WeatherService {
  static String _apiKey = "1bece0ce30d2fd1e65791fc8ec7399da";

  static Future<Weather> fetchCurrentWeather({required String city}) async {
    var url =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric&lang=ru';
    final response = await http.post(url);
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  static Future<List<Weather>> fetchHourlyWeather(
      {required String city}) async {
    var url =
        'http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$_apiKey&units=metric&lang=ru';
    final response = await http.post(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['list'] as List<dynamic>;
      final List<Weather> result =
          List.generate(8, (i) => Weather.fromJson(data[i]));
      return result;
    } else {
      throw Exception('Failed to load weather');
    }
  }

  static Future<List<Weather>> fetchDailyWeather({required String city}) async {
    var url =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric&lang=ru';
    final response = await http.post(url);
    if (response.statusCode == 200) {
      var lat = json.decode(response.body)['coord']['lat'];
      var lon = json.decode(response.body)['coord']['lon'];
      url =
          'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=current,minutely,hourly,alerts&appid=$_apiKey&units=metric';
      final response2 = await http.post(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response2.body);
        final List<dynamic> data = jsonData['daily'] as List<dynamic>;
        final List<Weather> result =
        List.generate(7, (i) => Weather.fromJsonByDay(data[i]));
        return result;
      } else {
        throw Exception('Failed to load weather');
      }
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
