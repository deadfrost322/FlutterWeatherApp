import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key, required this.favourites}) : super(key: key);
  final List<String> favourites;

  @override
  _FavouritesPageState createState() => _FavouritesPageState(favourites:favourites);
}

class _FavouritesPageState extends State<FavouritesPage> {
  _FavouritesPageState({this.favourites = const []});

  List<String> favourites;

  setFav(List<String> list) async {
    SharedPreferences Prefs = await SharedPreferences.getInstance();
    await Prefs.setStringList('favourites', list);
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
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.chevron_left_rounded,
                          color: Colors.black,
                          size: 30,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        'Избранное',
                        style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              favourites.isNotEmpty ? Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: favourites.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                            height: 50,
                            width: 320,
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(222, 233, 255, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    offset: Offset(0, 2),
                                    blurRadius: 2,
                                  ),
                                  BoxShadow(
                                    color: Color.fromRGBO(
                                        255, 255, 255, 0.1),
                                    offset: Offset(0, -2),
                                    blurRadius: 2,
                                  )
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    favourites[index],
                                    style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.centerRight,
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(200, 218, 255, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.2),
                                            offset: Offset(2, 4),
                                            blurRadius: 4,
                                          ),
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.15),
                                            offset: Offset(0, -4),
                                            blurRadius: 4,
                                          )
                                        ]),
                                    child: Center(
                                      child: IconButton(
                                        icon:const Icon(Icons.close_rounded),
                                        onPressed: (){
                                          favourites.removeAt(index);
                                          setFav(favourites);
                                          Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation1, animation2) => FavouritesPage(favourites: favourites),
                                              transitionDuration: Duration.zero,
                                            ),
                                          );
                                        },)


                                    )),
                              ],
                            )),
                      );
                    }),
              ) : Container()
            ])));
  }
}
