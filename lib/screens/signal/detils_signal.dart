import 'package:flutter/material.dart';
import 'package:mysignal/models/signal.dart';
import 'package:mysignal/providers/app_provider.dart';
import 'package:provider/provider.dart';

import 'package:mysignal/core/theme/colors.dart';
import 'package:mysignal/widgets/common/custom_app_bar.dart';
import 'package:mysignal/models/category.dart';

class DetailsSignalScreen extends StatelessWidget {
  const DetailsSignalScreen(
      {super.key, required this.signal, required this.category});
  final Signal signal;
  final Category category;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: category.title,
        backgroundColor: AppColors.surface,
        titleColor: AppColors.textPrimary,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              category.icon,
              color: category.color,
              size: 30,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Image.asset(
                signal.urlImage,
                fit: BoxFit.cover,
              ),
            ),

            // Make content scrollable to avoid overflow on small screens
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: AppColors.surface,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 12),
                                Text(
                                  "${signal.title}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 18),
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          provider.toggleFavorite(signal.id);
                                        },
                                        child: Icon(
                                          provider.isFavorite(signal.id)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 33,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      Icon(
                                        Icons.reply,
                                        size: 33,
                                        color: AppColors.primary,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                "${signal.urlImageMean}",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Container(
                      width: double.infinity,
                      color: AppColors.surface,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                color: Colors.lime,
                                size: 30,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "معلومة",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "${signal.description ?? 'لا توجد معلومات'}",
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(height: 1.8),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      final signals = category.signals;
                      final id = signals.indexWhere((s) => s.id == signal.id);
                      if (id < 0) return;
                      final prevIdx = id - 1;
                      if (prevIdx >= 0) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailsSignalScreen(
                              signal: signals[prevIdx],
                              category: category,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('لا يوجد عنصر سابق')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "السابق",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      final signals = category.signals;
                      final idx = signals.indexWhere((s) => s.id == signal.id);
                      if (idx < 0) return;
                      final nextIdx = idx + 1;
                      if (nextIdx < signals.length) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailsSignalScreen(
                              signal: signals[nextIdx],
                              category: category,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('لا يوجد عنصر تالي')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "التالي",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
