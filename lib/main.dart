import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bee up to date',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 2;
  final List<String> _titles = ['Maps', 'Scan QR-code', 'Apiaries', 'Statistics'];
  final List<NavigationDestination> _destinations = const [
    NavigationDestination(
      icon: Icon(Icons.map_sharp),
      label: 'Maps',
    ),
    NavigationDestination(
      icon: Icon(Icons.qr_code_2),
      label: 'Scan',
    ),
    NavigationDestination(
      icon: Icon(Icons.home),
      label: 'Apiaries',
    ),
    NavigationDestination(
      icon: Icon(Icons.trending_up),
      label: 'Statistics',
    ),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentPageIndex]),
      ),
      body: [
        Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: const Text('Page 1'),
        ),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
        Container(
          color: Colors.yellow,
          alignment: Alignment.center,
          child: const Text('Page 4'),
        ),
      ][_currentPageIndex],
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: _destinations,
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (index) => _onItemTapped(index),
      ),
    );
  }
}
