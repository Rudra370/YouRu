import 'package:AudioPlayer/components/Colors.dart';
import 'package:flutter/material.dart';
import 'screens/player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouRu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: ColorCodes.cNavBar,
        ),
        scaffoldBackgroundColor: ColorCodes.cBackground,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CustomPlayer(),
    );
  }
}

