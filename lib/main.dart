
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const ConversorCriptoMonedas());
}

class ConversorCriptoMonedas extends StatelessWidget {
  const ConversorCriptoMonedas({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlue,
        ),
      ),
      home: HomeScreen(),
    );
  }
}