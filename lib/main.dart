//  //   ///
//  Import LIBRARIES
import 'package:flutter/material.dart';
//  Import FILES
import 'core_src/presentation/pages/app_bar_example.dart';
//  //   ///

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Signals Made Easy: Part 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const AppBarExample(),
    );
  }
}





//  //   ///
//  Import LIBRARIES
//  Import FILES
//  //   ///


