import 'package:flutter/material.dart';
import 'package:the_weather/Screens/HomeScreen.dart';

void main() {
  runApp(the_weather());
}

class the_weather extends StatelessWidget {
  const the_weather({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,

      ) ,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

