import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartCast',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Local data for demonstration purposes
    final List<String> demoData = [
      'assets/p2/iPhone 16 & 17 Pro - 9.png',
      'assets/p2/iPhone 16 & 17 Pro - 8.png',
      'assets/p2/iPhone 16 & 17 Pro - 7.png',
      'assets/p2/iPhone 16 & 17 Pro - 6.png',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('SmartCast')),
      body: ListView.builder(
        itemCount: demoData.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(demoData[index]),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Image ${index + 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
