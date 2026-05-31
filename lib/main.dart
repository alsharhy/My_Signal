import 'package:flutter/material.dart';
import 'package:mysignal/screens/home/home_page.dart';
import 'package:mysignal/providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:mysignal/core/theme/app_theme.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
