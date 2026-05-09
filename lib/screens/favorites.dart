import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mysignal/state/providers/app_provider.dart';
import 'package:mysignal/data/repositories/category_repository.dart';
import 'package:mysignal/widgets/common/custom_app_bar.dart';
import 'package:mysignal/widgets/common/custom_bottom_navigation.dart';
import 'package:mysignal/widgets/common/sub_category_card.dart';
import 'package:mysignal/models/sub_categoris.dart';
import 'package:mysignal/models/categoris.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final CategoryRepository _repository = CategoryRepository();
  List<SubCategory> _favoriteSubCategories = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    final favorites = context.read<AppProvider>().favorites;
    final allSubCategories = <SubCategory>[];
    
    for (final category in _repository.getAllCategories()) {
      allSubCategories.addAll(category.subCategories);
    }
    
    setState(() {
      _favoriteSubCategories = allSubCategories
          .where((sub) => favorites.contains(sub.id))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return  
         
            _favoriteSubCategories.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'لا توجد عناصر في المفضلة',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      Text(
                        'أضف بعض العناصر إلى المفضلة',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _favoriteSubCategories.length,
                  itemBuilder: (context, index) {
                  
                    final item = _favoriteSubCategories[index];
                    return SubCategoryCard(
                      id: item.id,
                      title: item.titleSubCatecory,
               
                      urlImage: item.urlImage,
                      onTap: () {
                        // Handle tap on favorite item
                      },
                    );
                  },
               
         
        );
      },
    );
  }
}
