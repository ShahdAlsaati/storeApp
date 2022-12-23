import 'package:flutter/material.dart';
import 'package:storeapp/Screens/home_screen.dart';
import 'package:storeapp/constant/global_color.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scaffoldBackgroundColor: lightScaffoldColor,
        primaryColor: lightCardColor,
        backgroundColor: lightBackgroundColor,
        appBarTheme:AppBarTheme (
        iconTheme: IconThemeData(
          color: lightIconColor,
        ),
          backgroundColor: lightScaffoldColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: lightTextColor,fontSize: 22,fontWeight: FontWeight.bold,

          ),
          elevation: 0,
        ),
        iconTheme: IconThemeData(color: lightIconColor),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionColor: Colors.blue
        ),
        primarySwatch: Colors.blue,
        cardColor: lightCardColor,
        brightness: Brightness.light,
        colorScheme:ThemeData().colorScheme.copyWith(
          secondary: lightIconColor,
          brightness: Brightness.light,
        )
      ),

      home:  HomeScreen(),
    );
  }
}

