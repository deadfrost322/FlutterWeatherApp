//lib/main_page.dart

import 'dart:developer';

import 'package:pogoda/settings_page.dart';
import 'favourites_page.dart';
import 'weather_by_day_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pogoda/weather_by_day_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:intl/intl.dart';
import 'package:pogoda/search_page.dart';
import 'package:pogoda/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about_developer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.currentWeather,
      required this.hourlyWeather,
      required this.dailyWeather,
      required this.tempState,
      required this.windState,
      required this.prState})
      : super(key: key);
  final Weather currentWeather;
  final List<Weather> hourlyWeather;
  final List<Weather> dailyWeather;
  final bool tempState;
  final bool windState;
  final bool prState;

  @override
  State<MyHomePage> createState() =>
      _MyHomePageState(currentWeather, hourlyWeather, dailyWeather, tempState, windState, prState);
}

class _MyHomePageState extends State<MyHomePage> with RouteAware {
  _MyHomePageState(this.currentWeather, this.hourlyWeather, this.dailyWeather,
      this.tempState, this.windState, this.prState);

  final Weather currentWeather;
  final List<Weather> hourlyWeather;
  final List<Weather> dailyWeather;
  final bool tempState;
  final bool windState;
  final bool prState;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd MMM. yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  Widget weatherByTime(BuildContext context, int timeNum) {
    return Container(
      width: 65,
      height: 122,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(224, 233, 253, 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(3, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(7, 7, 0, 0),
                    child: Text(
                      hourlyWeather[timeNum].time.hour.toString() +
                          ':' +
                          hourlyWeather[timeNum].time.minute.toString() +
                          '0',
                      style: GoogleFonts.manrope(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(6, 7, 0, 0),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset(_weatherImageState(
                            hourlyWeather[timeNum].type, context)),
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 5),
                    child: Text((tempState ? (hourlyWeather[timeNum].temperature*1.8+32).floor().toString():hourlyWeather[timeNum].temperature.toString())
                       + (tempState ? '°f' : '°c'),
                      style: GoogleFonts.manrope(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      key: _scaffoldKey,
      body: SlidingUpPanel(
        minHeight: 256,
        maxHeight: 450,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        panel: Container(
          height: 450,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(226, 235, 255, 1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
          child: Column(
            children: [
              //синяя фигулина сверху
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 11),
                    height: 5,
                    width: 60,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(3, 140, 254, 1),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  )
                ],
              ),
              //боксы с погодой по часам
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //почасовой бокс 1
                    weatherByTime(context, 0),
                    //почасовой бокс 2
                    weatherByTime(context, 2),
                    //почасовой бокс 3
                    weatherByTime(context, 4),
                    //почасовой бокс 4
                    weatherByTime(context, 6),
                  ],
                ),
              ),
              //строка с боксами температура и влажность
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //температура
                    Container(
                        width: 160,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(224, 233, 253, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(3, 3))
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.thermostat_outlined,
                                  color: Color.fromRGBO(90, 90, 90, 1),
                                ),
                                Text(
                                  " " + (tempState ? (currentWeather.feelsLikeTemp*1.8+32).floor().toString():currentWeather.feelsLikeTemp.toString()),
                                  style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                    (tempState ? '°f':'°c'),
                                  style: GoogleFonts.manrope(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          const Color.fromRGBO(90, 90, 90, 1)),
                                ),
                              ],
                            )
                          ],
                        )),
                    //влажность
                    Container(
                        width: 160,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(224, 233, 253, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(3, 3))
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.water,
                                  color: Color.fromRGBO(90, 90, 90, 1),
                                ),
                                Text(
                                  " " + currentWeather.humidity.toString(),
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
                                      color:
                                          const Color.fromRGBO(90, 90, 90, 1)),
                                ),
                              ],
                            )
                          ],
                        ))
                  ],
                ),
              ),
              //строка с боксами ветер и давление
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //ветер
                    Container(
                        width: 160,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(224, 233, 253, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(3, 3))
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.air_rounded,
                                  color: Color.fromRGBO(90, 90, 90, 1),
                                ),
                                Text(
                                  " " + (windState ? (currentWeather.wind*3.6).floor().toString():(currentWeather.wind.toString())),
                                  style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                    (windState ? 'км/ч':'м/с'),
                                  style: GoogleFonts.manrope(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          const Color.fromRGBO(90, 90, 90, 1)),
                                ),
                              ],
                            )
                          ],
                        )),
                    //давление
                    Container(
                        width: 160,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(224, 233, 253, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(3, 3))
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  " " +
                                      (prState ? (currentWeather.pressure) : (currentWeather.pressure*0.75).floor())
                                          .toString(),
                                  style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text( (prState ? 'гПа' : 'мм.рт.ст'),
                                  style: GoogleFonts.manrope(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          const Color.fromRGBO(90, 90, 90, 1)),
                                ),
                              ],
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
        collapsed: Container(
          height: 256,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(226, 235, 255, 1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
          child: Column(
            children: [
              //фиговина сверху
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 11),
                    height: 5,
                    width: 60,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(3, 140, 254, 1),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  )
                ],
              ),
              //боксы с погодой по часам
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //почасовой бокс 1
                    weatherByTime(context, 0),
                    //почасовой бокс 2
                    weatherByTime(context, 2),
                    //почасовой бокс 3
                    weatherByTime(context, 4),
                    //почасовой бокс 4
                    weatherByTime(context, 6),
                  ],
                ),
              ),
              //кнопка "Прогноз на неделю"
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeatherByDayPage(
                                    dailyWeather: dailyWeather, tempState:tempState, windState:windState, prState:prState
                                  )),
                        );
                      },
                      color: const Color.fromRGBO(234, 240, 255, 1),
                      child: Text('Прогноз на неделю',
                          style: GoogleFonts.manrope(
                            color: const Color.fromRGBO(3, 140, 254, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                      shape: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(3, 140, 254, 1),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(10)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/main_light/light_bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              //"АппБар"
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //открытие дровера
                  IconButton(
                      padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                      onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                      icon: const Icon(Icons.menu),
                      color: Colors.white),
                  //заголовок город
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                      child: Text(
                        currentWeather.cityName,
                        style: GoogleFonts.manrope(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  //кнопка перехода к поиску
                  IconButton(
                    icon: const Icon(Icons.control_point),
                    onPressed: () {
                        goToSearch();
                    },
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(0, 50, 20, 0),
                  ),
                ],
              ),
              //большая температура и дата
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //температура
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Text((tempState ? (currentWeather.feelsLikeTemp*1.8+32).floor().toString() : currentWeather.feelsLikeTemp.toString())
                        + (tempState ?  '°F' : '°C'),
                        style: GoogleFonts.manrope(
                            fontSize: 90,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ),
                  //дата
                  Text(currentDate(),
                      style: GoogleFonts.manrope(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 42, 0, 0),
              height: MediaQuery.of(context).size.height,
              width: (MediaQuery.of(context).size.height) * 0.4,
              color: const Color.fromRGBO(226, 235, 255, 1),
              child: Column(
                children: [
                  ListTile(
                      title: Text('Weather App',
                          style: GoogleFonts.manrope(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ))),
                  ListTile(
                    onTap: () => goToSettings(),
                    leading: const Icon(Icons.settings_outlined,
                        color: Colors.black),
                    title: Text('Настрйки',
                        style: GoogleFonts.manrope(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                  ListTile(
                    onTap: () => goToFav(),
                    leading:
                        const Icon(Icons.favorite_border, color: Colors.black),
                    title: Text('Избранное',
                        style: GoogleFonts.manrope(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                  ListTile(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => About())),
                    leading: const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.black,
                    ),
                    title: Text('О приложении',
                        style: GoogleFonts.manrope(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  setDefFav() async{
    SharedPreferences Prefs = await SharedPreferences.getInstance();
    List<String> fav = ['Санкт-Петербург'];
    await Prefs.setStringList('favourites', fav);
  }

  getFav() async {
    SharedPreferences Prefs = await SharedPreferences.getInstance();
    if (Prefs.getStringList('favourites')==null){
      setDefFav();
      return Prefs.getStringList('favourites');
    }
    else{
      return Prefs.getStringList('favourites');
    }
  }

  void goToSearch() async{
    List<String> favourites = await getFav();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchPage(favourites: favourites),
        ));
  }

  void goToFav() async{
    List<String> favourites = await getFav();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavouritesPage(favourites: favourites),
        ));
  }

  void goToSettings() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SettingsPage(
                tempState: tempState, windState: windState, prState: prState, city: currentWeather.cityName)));
  }

  //выбор изображения по типу погоды для погоды по часам
  String _weatherImageState(String weather, BuildContext context) {
    switch (weather) {
      case 'Clear':
        return 'assets/main_light/Иконка Солнце.png';
      case 'Thunderstorm':
        return 'assets/main_light/Иконка Молния.png';
      case 'Rain':
        return 'assets/main_light/Иконка дождь 3 капли.png';
      case 'Snow':
        return 'assets/main_light/Иконка дождь 3 капли.png';
      case 'Drizzle':
        return 'assets/main_light/Иконка дождь.png';
      default:
        return 'assets/main_light/Иконка облака.png';
    }
  }
}
