import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/loginscreen.dart';
import 'package:flutter/material.dart';
import '../model/sinhvien_provider.dart';

// Import các file của bạn ở đây (đảm bảo đúng đường dẫn)
// import 'package:your_project/provider/sinhvien_provider.dart';
// import 'package:your_project/screens/login_screen.dart';

void main() {
  runApp(
    // Bọc ứng dụng trong MultiProvider để sau này bạn thêm nhiều Provider khác (như Chi tiêu)
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SinhVienProvider()),
        // Nếu có Provider cho Quản lý chi tiêu thì thêm ở đây:
        // ChangeNotifierProvider(create: (_) => ChiTieuProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HUIT Mobile Programming',
      debugShowCheckedModeBanner: false, // Tắt chữ "Debug" ở góc màn hình
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Sử dụng giao diện Material 3 hiện đại
      ),
      // Màn hình đầu tiên xuất hiện khi mở app là LoginScreen
      home: LoginScreen(),
    );
  }
}