import 'package:flutter/material.dart';
import 'package:mysignal/screens/category/category.dart';

import 'package:mysignal/screens/favorites/favorites.dart';
import 'package:mysignal/widgets/common/custom_bottom_navigation.dart';
import 'package:mysignal/core/theme/colors.dart';

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
  ];

  static const List<Widget> pages = [
    CategoryPage(),
    FavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
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
          child: Text(
            pagesNames[currentIndex],
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
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
