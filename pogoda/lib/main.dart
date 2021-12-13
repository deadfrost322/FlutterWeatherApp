//lib/main.dart

import 'package:pogoda/main_page.dart';
import 'package:pogoda/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pogoda/weather.dart';
import 'package:pogoda/weather_service.dart';

import 'about_developer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashPage(city: 'Санкт-петербург'),
    );
  }
}

class SplashPage extends StatefulWidget {
  SplashPage({Key? key, required this.city}) : super(key: key);
  final String city;

  @override
  State<SplashPage> createState() => _SplashPageState(city);
}

class _SplashPageState extends State<SplashPage> {
  _SplashPageState(this.city);

  String city;

  getSettings(String setting) async {
    SharedPreferences settingsPrefs = await SharedPreferences.getInstance();
    return (settingsPrefs.getBool(setting) ?? false);
  }

  Future<Widget> loadAfterFuture(String city) async {
    Weather currentWeather =
        await WeatherService.fetchCurrentWeather(city: city);
    List<Weather> hourlyWeather =
        await WeatherService.fetchHourlyWeather(city: city);
    List<Weather> dailyWeather =
        await WeatherService.fetchDailyWeather(city: city);
    bool tempState = await (getSettings('tempState')??false);
    bool windState = await (getSettings('windState')??false);
    bool prState = await (getSettings('prState')??false);
    return MyHomePage(
        currentWeather: currentWeather,
        hourlyWeather: hourlyWeather,
        dailyWeather: dailyWeather,
        tempState: tempState,
        windState: windState,
        prState: prState,

    );
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: const Color.fromRGBO(226, 235, 255, 1),
      title: Text(
        'Weather app',
        style: GoogleFonts.manrope(
          fontSize: 25,
          fontWeight: FontWeight.w800,
        ),
      ),
      navigateAfterFuture: loadAfterFuture(city),
    );
  }
}
