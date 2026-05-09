import 'package:flutter/material.dart';
import 'package:mysignal/widgets/common/sub_category_card.dart';
import 'package:mysignal/models/categoris.dart';
import 'package:mysignal/models/sub_categoris.dart';
import 'package:mysignal/widgets/common/custom_app_bar.dart';
import 'package:mysignal/widgets/common/custom_bottom_navigation.dart';
import 'package:mysignal/widgets/common/search_field.dart';
 
class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key, required this.category});
  final Category category;
  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SubCategory> _filteredSubCategories = [];

  @override
  void initState() {
    super.initState();
    _filteredSubCategories = widget.category.subCategories;
    _searchController.addListener(_filterSubCategories);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterSubCategories);
    _searchController.dispose();
    super.dispose();
  }

  void _filterSubCategories() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      if (query.isEmpty) {
        _filteredSubCategories = widget.category.subCategories;
      } else {
        _filteredSubCategories = widget.category.subCategories
            .where((sub) => sub.titleSubCatecory.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.category.title,
        backgroundColor: Colors.white,
        titleColor: Colors.black,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(
              widget.category.icon,
              size: 30,
              color: widget.category.color,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('الصنف الحالي: ${widget.category.title}')),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          // Search Text Field
          CustomSearchField(
            controller: _searchController,
            hintText: 'ابحث في ${widget.category.title}...',
            onChanged: (value) {
              _filterSubCategories();
            },
          ),
          // List of SubCategories
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSubCategories.length,
              itemBuilder: (context, index) {
                final item = _filteredSubCategories[index];
                return SubCategoryCard(
                  id: item.id,
                  title: item.titleSubCatecory,
                  urlImage: item.urlImage,
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
      
    );
  }
}
