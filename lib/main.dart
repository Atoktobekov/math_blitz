import 'package:flutter/material.dart';
import 'package:math_blitz/presentation/screens/main_menu_screen.dart';
import 'package:math_blitz/presentation/screens/game_screen.dart'; // Твой GameScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Blitz',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainMenuScreen(),
        '/game': (context) => GameScreen(),
      },
    );
  }
}
