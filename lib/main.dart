import 'package:flutter/material.dart';
import 'package:mysignal/screens/home/home_page.dart';
import 'package:mysignal/providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:mysignal/core/theme/app_theme.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // الرجاء وضع مفاتيح Supabase الخاصة بك هنا
  const String supabaseUrl = 'https://sxabudzddctykgymigwe.supabase.co';
  const String supabaseAnonKey =
      'sb_publishable_rvVOIurN-zdKC9t6VqwLXw_h7acwa85';

  if (supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        publishableKey: supabaseAnonKey,
      );
    } catch (e) {
      debugPrint('Error initializing Supabase: $e');
    }
  } else {
    debugPrint(
        'Supabase credentials are empty. Please add them in lib/main.dart');
  }

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
