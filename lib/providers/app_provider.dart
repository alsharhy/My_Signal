import 'package:flutter/material.dart';
import 'package:mysignal/models/category.dart';
import 'package:mysignal/data/repositories/category_repository.dart';

class AppProvider extends ChangeNotifier {
  final CategoryRepository _repository = CategoryRepository();

  List<Category> _categories = [];
  Set<int> _favorites = {};
  int _selectedTabIndex = 0;

 
  List<Category> get categories => _categories;
  Set<int> get favorites => _favorites;
  int get selectedTabIndex => _selectedTabIndex;

  AppProvider() {
    initializeCategories();
  }
 
  void initializeCategories() {
    _categories = _repository.getAllCategories();
    notifyListeners();
  }

  

  void changeTabIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  // Favorite methods
  bool isFavorite(int id) {
    return _favorites.contains(id);
  }

  void toggleFavorite(int id) {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    notifyListeners();
  }

  
  List<Category> searchCategories(String query) {
    return _repository.searchCategories(query);
  }
}
