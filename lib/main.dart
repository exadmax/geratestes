import 'package:flutter/material.dart';

import 'pages/home_menu_page.dart';

void main() {
  runApp(const GeratestesApp());
}

class GeratestesApp extends StatelessWidget {
  const GeratestesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );

    return MaterialApp(
      title: 'Geratestes',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const HomeMenuPage(),
    );
  }
}
