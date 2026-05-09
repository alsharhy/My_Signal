import 'package:flutter/foundation.dart';

class NavigationNotifier extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int index, {bool isHomePage = false}) {
    _currentIndex = index;

    notifyListeners();
  }
}
