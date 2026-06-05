import 'package:flutter/material.dart';
import 'package:mysignal/models/category.dart';
import 'package:mysignal/data/repositories/category_repository.dart';

class AppProvider extends ChangeNotifier {
  final CategoryRepository _repository = CategoryRepository();
  Set<int> _favorites = {};
  List<Category> get categories {
    return _repository.getAllCategories();
  }

  Set<int> get favorites {
    return _favorites;
  }

  AppProvider();

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
 
}
