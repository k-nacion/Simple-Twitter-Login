import 'package:flutter/material.dart';
import 'package:forms/pages/login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

    return MaterialApp(
      title: 'Twitter Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: colorScheme,
        useMaterial3: true,
      ).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(55),
            borderSide: BorderSide.none,
          ),
          filled: true,
        ),
      ),
      routes: <String, Widget Function(BuildContext context)>{
        '/': (context) => const LoginPage(),
      },
    );
  }
}
