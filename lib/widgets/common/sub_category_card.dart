import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mysignal/state/providers/app_provider.dart';

class SubCategoryCard extends StatelessWidget {
  final int id;
  final String title;
  final String? urlImage;
  final VoidCallback onTap;
  final String? subTitle;

  const SubCategoryCard({
    super.key,
    required this.id,
    required this.title,
    this.urlImage,
    this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        final isFavorite = provider.isFavorite(id);
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: onTap,
                      borderRadius: BorderRadius.circular(12),
                      child: Row(
                        children: [
                          // Leading icon or image
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: urlImage != null
                                ? ClipOval(
                                    child: Image.network(
                                      urlImage!,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(
                                    Icons.category,
                                    size: 24,
                                  ),
                          ),
                          const SizedBox(width: 16),

                          // Title
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          // Favorite button
                          IconButton(
                            onPressed: () {
                              provider.toggleFavorite(id);
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ));
      },
    );
  }
}
