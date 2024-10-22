import 'package:flutter/material.dart';
import 'app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Routing Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple, // Change background color
          foregroundColor: Colors.white, // Change text/icon color
          elevation: 4.0, // Add shadow effect to separate from background
        ),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/', // Start with the main page
    );
  }
}
