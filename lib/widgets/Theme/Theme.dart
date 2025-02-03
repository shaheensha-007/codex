import 'package:flutter/material.dart';

ThemeData lightMode=ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Colors.white,
      primary: Colors.white54,
      secondary: Colors.black,//hintext
      onPrimary: Colors.black,//Text

    )
);


ThemeData darkMode=ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Color(0xff0A1433),
      primary: Colors.white10,
      secondary: Colors.grey,//hinttext
      onPrimary: Colors.white, //text



    )
);