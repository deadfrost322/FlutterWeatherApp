//lib/about_developer.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
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
              padding: const EdgeInsets.fromLTRB(10, 45, 0, 0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.chevron_left_rounded,
                        color: Colors.black,
                        size: 30,
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      'О приложении',
                      style: GoogleFonts.manrope(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 134, 0, 0),
                  child: Container(
                    width: 224,
                    height: 54,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(222, 233, 255, 100),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05),

                        ),
                        BoxShadow(
                            color: Color.fromRGBO(222, 233, 255, 1),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4)),
                        BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 0.05),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Weather app',
                        style: GoogleFonts.manrope(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 144),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery
                        .of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                        color: Color.fromRGBO(226, 235, 255, 100),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.07),
                            spreadRadius: 0,
                            blurRadius: 26,
                          ),
                        ]),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 23),
                              child: Text('by ITMO University',
                                  style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15
                                  )
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text('Версия 1.0',
                                  style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 10,
                                      color: const Color.fromARGB(500, 74, 74, 74)
                                  )
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text('от 16 ноября 2021',
                                  style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 10,
                                      color: const Color.fromARGB(500, 74, 74, 74)
                                  )
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 300),
                            //   child:
                                  Text('2021',
                                  style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 10,
                                  )
                              ),
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
