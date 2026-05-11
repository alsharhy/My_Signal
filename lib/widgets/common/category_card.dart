import 'package:flutter/material.dart';
import 'package:mysignal/core/config/app_constant.dart';
 import 'package:mysignal/models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category element;

  const CategoryCard({
    super.key,
    required this.element,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.2),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔥 الأيقونة فقط بدون أي خلفية
            Icon(
              element.icon,
              size: 90,
              color: element.color,
            ),

            const SizedBox(height: 12),

            Text(
              element.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 4),

            Text(
              '${element.numberOf} عنصر',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}