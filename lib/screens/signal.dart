import 'package:flutter/material.dart';
import 'package:mysignal/models/category.dart';
import 'package:mysignal/widgets/common/sub_category_card.dart';
import 'package:mysignal/models/signal.dart';
import 'package:mysignal/screens/detils_signal.dart';
import 'package:mysignal/widgets/common/custom_app_bar.dart';
import 'package:mysignal/widgets/common/search_field.dart';
 
class SignalScreen extends StatefulWidget {
  const SignalScreen({super.key, required this.category});
  final Category category;
  @override
  State<SignalScreen> createState() => _SSignalScreenState();
}

class _SSignalScreenState extends State<SignalScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Signal> _filteredSignals = [];

  @override
  void initState() {
    super.initState();
    _filteredSignals = widget.category.signals;
    _searchController.addListener(_filterSignals);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterSignals);
    _searchController.dispose();
    super.dispose();
  }

  void _filterSignals() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      if (query.isEmpty) {
        _filteredSignals = widget.category.signals;
      } else {
        _filteredSignals = widget.category.signals
            .where((signal) => signal.title.toLowerCase().contains(query))
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
              _filterSignals();
            },
          ),
          // List of Signals
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSignals.length,
              itemBuilder: (context, index) {
                final item = _filteredSignals[index];
                return SubCategoryCard(
                  id: item.id,
                  title: item.title,
                  urlImage: item.urlImage,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsSignalScreen(signal: item),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      
    );
  }
}
