import 'package:flutter/material.dart';
import 'package:mysignal/state/providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:mysignal/models/signal.dart';

class DetailsSignalScreen extends StatelessWidget {

  final Signal signal;

  const DetailsSignalScreen({
    super.key,
    required this.signal,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(signal.title),
            actions: [
          
              

            ],
          ),

          body: Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [
                Expanded(child:Image.asset(
                  signal.urlImage,
                  width: 150,
                  height: 150,
                ),
 ),
                
                const SizedBox(height: 20),

                Text(
                  signal.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),

        );
      },
    );
  }
}