 
 import 'package:mysignal/models/category.dart';
import 'package:mysignal/data/datasources/category_data.dart';
 import 'package:mysignal/models/signal.dart';
class CategoryRepository {
  static final CategoryRepository _instance = CategoryRepository._internal();
  factory CategoryRepository() => _instance;
  CategoryRepository._internal();

  List<Category> getAllCategories() {
    return mainCategories;
  }

  Category? getCategoryById(int id) {
    try {
      return mainCategories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Category> searchCategories(String query) {
    if (query.isEmpty) return mainCategories;
    
    return mainCategories.where((category) {
      return category.title.toLowerCase().contains(query.toLowerCase()) ||
          category.signals.any((signal) => 
              signal.title.toLowerCase().contains(query.toLowerCase()));
    }).toList();
  }

  List<Signal> getSubCategoriesByCategoryId(int categoryId) {
    final category = getCategoryById(categoryId);
    return category?.signals ?? [];
  }

  Signal? getSubCategoryById(int categoryId, int subCategoryId) {
    final subCategories = getSubCategoriesByCategoryId(categoryId);
    try {
      return subCategories.firstWhere((sub) => sub.id == subCategoryId);
    } catch (e) {
      return null;
    }
  }
}
