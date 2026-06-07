import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mysignal/providers/app_provider.dart';
import 'package:mysignal/core/theme/colors.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // Controllers for Category Form
  final _categoryFormKey = GlobalKey<FormState>();
  final _categoryNameController = TextEditingController();

  // Controllers for Signal Form
  final _signalFormKey = GlobalKey<FormState>();
  final _signalNameController = TextEditingController();
  final _signalImageUrlController = TextEditingController();
  final _signalMeanUrlController = TextEditingController();
  final _signalDescController = TextEditingController();

  // Selected icon and color for new category
  IconData selectedIcon = Icons.directions_run;
  Color selectedColor = const Color(0xFFB0E0E6);

  // Selected category for new signal
  int? selectedCategoryId;

  // Icons to choose from
  final List<IconData> predefinedIcons = [
    Icons.directions_run,
    Icons.fastfood,
    Icons.family_restroom,
    Icons.emoji_emotions,
    Icons.sports_soccer,
    Icons.format_list_numbered,
    Icons.pets,
    Icons.school,
    Icons.work,
    Icons.home,
    Icons.medical_services,
    Icons.shopping_cart,
  ];

  // Colors to choose from
  final List<Color> predefinedColors = [
    const Color(0xFFB0E0E6),
    const Color(0xFFFFE8A3),
    const Color(0xFFB7E4C7),
    const Color(0xFFFFB6C1),
    const Color(0xFFFFB86B),
    const Color(0xFFD8B4FE),
    const Color(0xFFD7C4A5),
    const Color(0xFF3498DB),
    const Color(0xFFE74C3C),
    const Color(0xFF2ECC71),
  ];

  @override
  void dispose() {
    _categoryNameController.dispose();
    _signalNameController.dispose();
    _signalImageUrlController.dispose();
    _signalMeanUrlController.dispose();
    _signalDescController.dispose();
    super.dispose();
  }

  void _saveCategory() async {
    if (_categoryFormKey.currentState!.validate()) {
      final name = _categoryNameController.text.trim();
      final provider = context.read<AppProvider>();

      try {
        await provider.addCategory(name, selectedIcon, selectedColor);
        _categoryNameController.clear();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إضافة القسم بنجاح!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _saveSignal() async {
    if (_signalFormKey.currentState!.validate()) {
      if (selectedCategoryId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('الرجاء اختيار القسم أولاً'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      final provider = context.read<AppProvider>();

      try {
        await provider.addSignal(
          categoryId: selectedCategoryId!,
          title: _signalNameController.text.trim(),
          urlImage: _signalImageUrlController.text.trim(),
          urlImageMean: _signalMeanUrlController.text.trim(),
          description: _signalDescController.text.trim(),
        );

        _signalNameController.clear();
        _signalImageUrlController.clear();
        _signalMeanUrlController.clear();
        _signalDescController.clear();

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إضافة الإشارة بنجاح!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'لوحة تحكم المسؤول',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            bottom: const TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(icon: Icon(Icons.category), text: 'قسم جديد'),
                Tab(icon: Icon(Icons.add_to_home_screen), text: 'إشارة جديدة'),
              ],
            ),
          ),
          body: Consumer<AppProvider>(
            builder: (context, provider, child) {
              final categoriesList = provider.categories;

              return TabBarView(
                children: [
                  // --- TAB 1: ADD CATEGORY ---
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _categoryFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'إنشاء قسم رئيسي جديد',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _categoryNameController,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              labelText: 'اسم القسم',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.title),
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'يرجى إدخال اسم القسم';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'اختر أيقونة القسم:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: predefinedIcons.length,
                            itemBuilder: (context, index) {
                              final icon = predefinedIcons[index];
                              final isSelected = selectedIcon == icon;
                              return InkWell(
                                onTap: () =>
                                    setState(() => selectedIcon = icon),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.blue
                                            .withValues(alpha: 0.15)
                                        : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.grey.shade300,
                                      width: isSelected ? 2 : 1,
                                    ),
                                  ),
                                  child: Icon(icon,
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.grey.shade700,
                                      size: 28),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'اختر لون القسم:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: predefinedColors.length,
                              itemBuilder: (context, index) {
                                final color = predefinedColors[index];
                                final isSelected =
                                    selectedColor.toARGB32() ==
                                        color.toARGB32();
                                return GestureDetector(
                                  onTap: () =>
                                      setState(() => selectedColor = color),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.transparent,
                                        width: isSelected ? 3 : 0,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.1),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        )
                                      ],
                                    ),
                                    child: isSelected
                                        ? const Icon(Icons.check,
                                            color: Colors.black)
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _saveCategory,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'حفظ القسم الجديد',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- TAB 2: ADD SIGNAL ---
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _signalFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'إضافة إشارة جديدة للقسم',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),

                          // Dropdown for Category selection
                          DropdownButtonFormField<int>(
                            initialValue: selectedCategoryId,
                            decoration: InputDecoration(
                              labelText: 'اختر القسم التابع له الإشارة',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon:
                                  const Icon(Icons.category_outlined),
                            ),
                            items: categoriesList.map((cat) {
                              return DropdownMenuItem<int>(
                                value: cat.id,
                                child: Text(cat.title),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedCategoryId = val;
                              });
                            },
                            validator: (val) =>
                                val == null ? 'الرجاء اختيار القسم' : null,
                          ),
                          const SizedBox(height: 16),

                          // Signal Title
                          TextFormField(
                            controller: _signalNameController,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              labelText: 'اسم الإشارة',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.text_fields),
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'يرجى إدخال اسم الإشارة';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Signal Image URL
                          TextFormField(
                            controller: _signalImageUrlController,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              labelText: 'رابط صورة الإشارة (من الإنترنت)',
                              helperText:
                                  'مثال: https://example.com/image.jpg',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.image),
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'يرجى إدخال رابط الصورة';
                              }
                              if (!val.startsWith('http')) {
                                return 'الرجاء إدخال رابط يبدأ بـ http';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Signal Mean Image URL
                          TextFormField(
                            controller: _signalMeanUrlController,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              labelText:
                                  'رابط صورة المعنى التوضيحي (من الإنترنت)',
                              helperText:
                                  'مثال: https://example.com/mean.jpg',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon:
                                  const Icon(Icons.help_center_outlined),
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'يرجى إدخال رابط صورة التوضيح';
                              }
                              if (!val.startsWith('http')) {
                                return 'الرجاء إدخال رابط يبدأ بـ http';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Description
                          TextFormField(
                            controller: _signalDescController,
                            textAlign: TextAlign.right,
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: 'الوصف / معلومات عن الإشارة',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.description),
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'يرجى إدخال الوصف';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),

                          // Save Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _saveSignal,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'حفظ الإشارة الجديدة',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
