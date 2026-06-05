import 'package:flutter_test/flutter_test.dart';

import 'package:mysignal/providers/app_provider.dart';
import 'package:mysignal/data/repositories/category_repository.dart';
import 'package:mysignal/widgets/common/custom_app_bar.dart';

import 'package:mysignal/widgets/common/custom_bottom_navigation.dart';
import 'package:mysignal/screens/home/home_page.dart';
import 'package:mysignal/screens/favorites/favorites.dart';

void main() {
  group('Import Tests', () {
    test('All imports should work correctly', () {
      // Test that all classes can be instantiated without errors
      expect(() => AppProvider(), returnsNormally);
      expect(() => CategoryRepository(), returnsNormally);
      expect(() => const CustomAppBar(title: 'Test'), returnsNormally);
      expect(() => CustomBottomNavigation(selectElemnt: 0, onTap: (i) {}),
          returnsNormally);
      expect(() => const HomePage(), returnsNormally);
      expect(() => const FavoritesPage(), returnsNormally);
    });
  });
}
