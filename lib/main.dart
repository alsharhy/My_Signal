import 'package:flutter/material.dart';
import 'package:mysignal/screens/home_page.dart';
import 'package:mysignal/state/providers/app_provider.dart';
import 'package:provider/provider.dart';
 

void main() {
  runApp(
   MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AppProvider()),
  ],
  child:const  MyApp(),
)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const MaterialApp( 
      debugShowCheckedModeBanner: false,
      home:HomePage(),
    );
  }
}