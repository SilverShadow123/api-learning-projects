import 'package:api_project/UI.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ApiUi(),
      theme: ThemeData(
        appBarTheme:  AppBarTheme(
          color: Colors.pinkAccent.shade100,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          )
        )
      ),

    );
  }
}
