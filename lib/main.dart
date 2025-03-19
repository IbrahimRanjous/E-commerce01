import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/theme/themes.dart';

void main() {
  // Todo: add widgets binding
  // Todo: init local storage
  // Todo: await native splash
  // Todo: initailize firebase
  // Todo: initialize authentication

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: Scaffold(),
    );
  }
}
