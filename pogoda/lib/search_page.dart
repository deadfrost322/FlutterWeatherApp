//lib/search_page.dart
import 'package:flutter/material.dart';
import 'package:pogoda/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.favourites}) : super(key: key);
  final List<String> favourites;

  @override
  _SearchPageState createState() {
    return _SearchPageState(favourites);
  }
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController textFieldController = TextEditingController();

  _SearchPageState(this.favourites);
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        decoration: const  BoxDecoration(
          color: Color.fromRGBO(226, 235, 255, 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(00, 40, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    color: Colors.transparent,
                    iconSize: 60,
                    icon: const Icon(
                      Icons.chevron_left_rounded,
                      color: Color.fromRGBO(50, 50, 50, 1),
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: TextFormField(

                      onFieldSubmitted: (text) {
                        favourites.add(text);
                        favourites = favourites.toSet().toList();
                        setFav(favourites);
                        _sendDataBack(context);
                      },
                      controller: textFieldController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: 'Введите название города...',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        textFieldController.clear();
                      });
                    },
                    icon: const Icon(Icons.cancel_rounded, color: Color.fromRGBO(50, 50, 50, 1),),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }



  void _sendDataBack(BuildContext context) {
    if (textFieldController.text.isEmpty) {
      Navigator.pop(context);
    } else {
      String textToSendBack = textFieldController.text;
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => SplashPage(city: textToSendBack),
    ));
    }
  }
}
