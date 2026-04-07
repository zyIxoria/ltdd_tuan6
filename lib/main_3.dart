import 'package:flutter/material.dart';
import 'screens/sanpham_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quan ly san pham',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SanPhamScreen(),
    );
  }
}