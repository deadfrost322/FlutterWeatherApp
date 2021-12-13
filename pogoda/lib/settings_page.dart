//lib/settings_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pogoda/main.dart';
import 'package:pogoda/switcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage(
      {Key? key,
      required this.tempState,
      required this.windState,
      required this.prState,
      required this.city})
      : super(key: key);
  final bool tempState;
  final bool windState;
  final bool prState;
  final String city;

  @override
  State<SettingsPage> createState() {
    return _SettingsState(tempState, windState, prState, city);
  }
}

class _SettingsState extends State<SettingsPage> {
  _SettingsState(this.tempState, this.windState, this.prState, this.city);

  final String city;
  bool tempState;
  bool windState;
  bool prState;

  setSettings(String setting, bool val) async {
    SharedPreferences settingsPrefs = await SharedPreferences.getInstance();
    await settingsPrefs.setBool(setting, val);
  }


  void goBack() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SplashPage(city: city)));
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
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 45, 0, 0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () => goBack(),
                        icon: const Icon(
                          Icons.chevron_left_rounded,
                          color: Colors.black,
                          size: 30,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        'Нстройки',
                        style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              //бокс настроек единиц измерения
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 32, 0, 16),
                    child: Text('Единицы измерения',
                        style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: const Color.fromRGBO(130, 130, 130, 1))),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2375,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(226, 235, 255, 1),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(255, 255, 255, 0.25),
                            spreadRadius: 0,
                            offset: Offset(0, -4),
                            blurRadius: 10,
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            spreadRadius: 0,
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Температура
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Температура',
                                style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: const Color.fromRGBO(51, 51, 51, 1)),
                              ),
                              CustomSwitch(
                                value: tempState,
                                onChanged: (bool val) {
                                  setSettings('tempState', val);
                                  setState(() {
                                    tempState = val;
                                  });
                                },
                                textFalse: '°C',
                                textTrue: '°F',
                              ),
                            ],
                          ),
                          //Разделитель
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8889,
                            height: 1,
                            color: const Color.fromRGBO(0, 0, 0, 0.15),
                          ),
                          //Скорость ветра
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Сила ветра',
                                style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: const Color.fromRGBO(51, 51, 51, 1)),
                              ),
                              CustomSwitch(
                                value: windState,
                                onChanged: (bool val) {
                                  setSettings('windState', val);
                                  setState(() {
                                    windState = val;
                                  });
                                },
                                textFalse: 'м/с',
                                textTrue: 'км/ч',
                              ),
                            ],
                          ),
                          //Разделитель
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8889,
                            height: 1,
                            color: const Color.fromRGBO(0, 0, 0, 0.15),
                          ),
                          //Давление
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Давление',
                                style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: const Color.fromRGBO(51, 51, 51, 1)),
                              ),
                              CustomSwitch(
                                value: prState,
                                onChanged: (bool val) {
                                  setSettings('prState', val);
                                  setState(() {
                                    prState = val;
                                  });
                                },
                                textFalse: 'мм.рт.ст.',
                                textTrue: 'гПа',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ])));
  }
}
