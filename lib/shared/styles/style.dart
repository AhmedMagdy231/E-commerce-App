import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Colors.blue,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  primarySwatch: Colors.blue,

  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness:  Brightness.dark,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    color: Colors.white,
    backwardsCompatibility: false,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,


    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.blue,
    type: BottomNavigationBarType.fixed,
  ),
  scaffoldBackgroundColor: Colors.white,
);

ThemeData darkTheme= ThemeData(
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness:  Brightness.light,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,

    ),
    color:  HexColor('333739'),
    backwardsCompatibility: false,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,


    ),


  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.blue,
    type: BottomNavigationBarType.fixed,
    backgroundColor:  HexColor('333739'),
    unselectedItemColor: Colors.grey,
  ),
);