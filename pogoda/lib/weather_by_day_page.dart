//lib/weather_by_day_page.dart

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pogoda/main.dart';
import 'package:pogoda/weather.dart';
import 'package:pogoda/weather_service.dart';

class WeatherByDayPage extends StatefulWidget {
  const WeatherByDayPage({Key? key, required this.dailyWeather, required this.tempState, required this.windState, required this.prState})
      : super(key: key);
  final List<Weather> dailyWeather;
  final bool tempState;
  final bool windState;
  final bool prState;

  @override
  State<WeatherByDayPage> createState() {
    return _WeatherByDayState(dailyWeather, tempState, windState, prState);
  }
}

class _WeatherByDayState extends State<WeatherByDayPage> {
  _WeatherByDayState(this.dailyWeather,  this.tempState,  this.windState,  this.prState);

  List<Weather> dailyWeather;
  final bool tempState;
  final bool windState;
  final bool prState;

  Widget weatherCard(BuildContext context, int i) {
    return Container(
        width: 320,
        height: 387,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(205, 218, 245, 1),
                  Color.fromRGBO(156, 188, 255, 1)
                ])),
        child: Column(
          children: [
            //Дата
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: Text(
                    dailyWeather[i].time.day.toString() +
                        ' ' +
                        monthConvertor(dailyWeather[i].time.month),
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
            //Иконка погоды
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: SizedBox(
                      width: 85 * 1.7,
                      height: 76 * 1.7,
                      child: Image.asset(_weatherImageState(
                          dailyWeather[i].type,
                          dailyWeather[i].description,
                          context))),
                )
              ],
            ),
            //Данные о погоде
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    //Температура
                    child: Row(
                      children: [
                        const Icon(
                          Icons.thermostat_outlined,
                          size: 24,
                          color: Color.fromRGBO(90, 90, 90, 1),
                        ),
                        Text(
                          " " + (tempState ? (dailyWeather[i].feelsLikeTemp*1.8+32).floor().toString() : dailyWeather[i].feelsLikeTemp.toString()),
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          (tempState ? '°f' : '°c'),
                          style: GoogleFonts.manrope(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromRGBO(90, 90, 90, 1)),
                        ),
                      ],
                    )),
                //Ветер
                Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 0, 0),
                    child: Row(children: [
                      const Icon(
                        Icons.air_rounded,
                        color: Color.fromRGBO(90, 90, 90, 1),
                      ),
                      Text(
                        " " + (windState ? (dailyWeather[i].wind*3.6).floor().toString() : dailyWeather[i].wind.toString()),
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        (windState ? 'км/ч' : 'м/с'),
                        style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(90, 90, 90, 1)),
                      ),
                    ])),
                //Влажность
                Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 0, 0),
                    child: Row(children: [
                      const Icon(
                        Icons.water,
                        color: Color.fromRGBO(90, 90, 90, 1),
                      ),
                      Text(
                        " " + dailyWeather[i].humidity.toString(),
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '%',
                        style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(90, 90, 90, 1)),
                      ),
                    ])),
                //Давление
                Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 0, 0),
                    child: Row(children: [
                      Text(
                        " " + (prState ? dailyWeather[i].pressure.toString() : (dailyWeather[i].pressure*0.75).floor().toString()),
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                      (prState ? 'гПа': 'мм.рт.ст'),
                        style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(90, 90, 90, 1)),
                      ),
                    ])),
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(226, 235, 255, 1),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 44, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Прогноз на неделю',
                      style: GoogleFonts.manrope(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return weatherCard(context, index);
                    },
                    duration: 300,
                    itemCount: 7,
                    itemWidth: 370,
                    itemHeight: 450,
                    layout: SwiperLayout.TINDER,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: const Color.fromRGBO(234, 240, 255, 1),
                      child: Text('Вернуться на главную',
                          style: GoogleFonts.manrope(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                      shape: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

  static String monthConvertor(int monthNumb) {
    switch (monthNumb) {
      case 1:
        return 'января';
      case 2:
        return 'февраля';
      case 3:
        return 'марта';
      case 4:
        return 'апреля';
      case 5:
        return 'мая';
      case 6:
        return 'июня';
      case 7:
        return 'июля';
      case 8:
        return 'августа';
      case 9:
        return 'сентября';
      case 10:
        return 'октября';
      case 11:
        return 'ноября';
      case 12:
        return 'декабря';
      default:
        return 'января';
    }
  }
}

String _weatherImageState(
    String weather, String description, BuildContext context) {
  switch (weather) {
    case 'Thunderstorm':
      return 'assets/card_icons/thunderstorm.png';
    case 'Rain':
      return 'assets/card_icons/rainy.png';
    case 'Snow':
      return 'assets/card_icons/snowy.png';
    case 'Drizzle':
      return 'assets/card_icons/rainy.png';
    case 'Clouds':
      if (description == 'few clouds: 11-25%') {
        return 'assets/card_icons/partly_cloudy.png';
      } else {
        return 'assets/card_icons/cloudy.png';
      }
    default:
      return 'assets/card_icons/cloudy.png';
  }
}
