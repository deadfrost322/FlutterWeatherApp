//lib/weather.dart

class Weather {
  final String cityName;
  final int temperature;
  final int wind;
  final int humidity;
  final int feelsLikeTemp;
  final int pressure;
  final String type;
  final DateTime time;
  final String description;

  Weather({required this.cityName,
    required this.temperature,
    required this.wind,
    required this.humidity,
    required this.feelsLikeTemp,
    required this.pressure,
    required this.type,
    required this.time,
    required this.description
  });

  static fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: double.parse(json['main']['temp'].toString()).toInt(),
        wind:  double.parse(json['wind']['speed'].toString()).toInt(),
        humidity: double.parse(json['main']['humidity'].toString()).toInt(),
        feelsLikeTemp: double.parse(json['main']['feels_like'].toString()).toInt(),
        pressure: double.parse(json['main']['pressure'].toString()).toInt(),
        type: json['weather'][0]['main'],
        description: json['weather'][0]['description'],
        time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000));
  }
  static fromJsonByDay(Map<String, dynamic> json) {
    return Weather(
        cityName: 'B)',
        temperature: double.parse(json['temp']["day"].toString()).toInt(),
        wind:  double.parse(json['wind_speed'].toString()).toInt(),
        humidity: double.parse(json['humidity'].toString()).toInt(),
        feelsLikeTemp: double.parse(json['feels_like']['day'].toString()).toInt(),
        pressure: double.parse(json['pressure'].toString()).toInt(),
        type: json['weather'][0]['main'],
        description: json['weather'][0]['description'],
        time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000));
  }



}
