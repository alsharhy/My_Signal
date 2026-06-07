import 'package:flutter/material.dart';
import 'package:mysignal/models/category.dart';
import 'package:mysignal/core/theme/colors.dart';

class CategoryCard extends StatelessWidget {
  final Category element;

  const CategoryCard({
    super.key,
    required this.element,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      elevation: 6,
      shadowColor: Colors.black.withValues(alpha: 0.2),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              element.icon,
              size: 80,
              color: element.color,
            ),
            const SizedBox(height: 12),
            Text(
              element.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '${element.numberOf} عنصر',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
