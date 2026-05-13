import 'package:flutter/material.dart';
import 'package:mysignal/screens/category.dart';
import 'package:mysignal/screens/exam.dart';
import 'package:mysignal/screens/favorites.dart';
import 'package:mysignal/widgets/common/custom_bottom_navigation.dart';
 import 'package:mysignal/core/config/app_constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  static const List<String> pagesNames = [
    "التصنيفات",
    "المفضلات",
    "الإختبار",
  ];

  static const List<Widget> pages = [
    CategoryPage(),
    FavoritesPage(),
    ExamPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstant.scaffoldBackgroundColorValue),
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: Text(pagesNames[currentIndex]),
        ),
      ),
      body: pages[currentIndex],

         
    bottomNavigationBar: CustomBottomNavigation(
  selectElemnt: currentIndex,
  onTap: (index) {
    setState(() {
      currentIndex = index;
    });
  },
),
    );
  }
}