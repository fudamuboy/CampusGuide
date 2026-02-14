import 'package:flutter/material.dart';
import 'data/mock_data.dart';
import 'models/campus_item.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CampusGuideApp());
}

class CampusGuideApp extends StatefulWidget {
  const CampusGuideApp({super.key});

  @override
  State<CampusGuideApp> createState() => _CampusGuideAppState();
}

class _CampusGuideAppState extends State<CampusGuideApp> {
  late final List<CampusItem> _items;

  @override
  void initState() {
    super.initState();
    _items = getMockData();
  }

  void _onStateChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampusGuide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: HomeScreen(items: _items, onStateChanged: _onStateChanged),
    );
  }
}
