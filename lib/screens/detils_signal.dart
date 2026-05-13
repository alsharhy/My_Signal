import 'package:flutter/material.dart';
import 'package:mysignal/models/signal.dart';
import 'package:mysignal/state/providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:mysignal/core/config/app_constant.dart';
import 'package:mysignal/widgets/common/custom_app_bar.dart';
import 'package:mysignal/models/category.dart';
class DetailsSignalScreen extends StatelessWidget {
  const DetailsSignalScreen({super.key, required this.signal, required this.category});
  final Signal signal;
  final Category category;
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
 appBar: CustomAppBar(
        title: category.title,
        backgroundColor: Colors.white,
        titleColor: Colors.black,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              category.icon,
              color: category.color,
              size: 30,
            ),
          ),

          const SizedBox(width: 10),
        ],
      ),


    
    
    
   body:  SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(),
            child: Image.asset(signal.urlImage
             ,
              fit: BoxFit.cover,
            ),
          ),

          Expanded(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              "${signal.title}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 35),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      provider.toggleFavorite(signal.id);
                                    },
                                    child: Icon(
                                      provider.isFavorite(signal.id)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 33,
                                      color:const  Color(AppConstant.primaryColorValue),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.reply,
                                    size: 33,
                                    color:const  Color(AppConstant.primaryColorValue),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),

                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            "${signal.urlImageMean}",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                /// المعلومات
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.lightbulb_outline,
                            color: Colors.lime,
                            size: 30,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "معلومة",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "${signal.description ?? 'لا توجد معلومات'}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 22,
                          height: 1.8,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// الازرار السفلية
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "التالي",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "السابق",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),);
  }
}
