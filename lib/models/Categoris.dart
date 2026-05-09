import 'package:flutter/material.dart';
import 'package:mysignal/models/sub_categoris.dart';

class Category {
  final int id;
  final String title;
  final IconData icon;
  final Color color;
  final int numberOf;
  final List<SubCategory> subCategories;

  const Category({
    required this.id,
    required this.title,
    required this.numberOf,
    required this.icon,
    required this.color,
    required this.subCategories,
  });
}
