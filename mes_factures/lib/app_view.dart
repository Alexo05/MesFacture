import 'package:flutter/material.dart';
import 'package:mes_factures/Screens/Home/HomeScreen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mes Factures",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
            surface: const Color.fromARGB(255, 244, 243, 243),
            // surface:  const Color(0xFF10493f),
            onSurface: Color.fromARGB(255, 20, 37, 63),
            primary: const Color(0xFFff7c7c),
            secondary: Colors.white,
            tertiary: const Color(0xFF7A7A7A)),
      ),
      home: const HomeScreen(),
    );
  }
}