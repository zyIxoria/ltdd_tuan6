import 'package:flutter/material.dart';
import '../model/UserAccount.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller để lấy dữ liệu từ TextField
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Danh sách giả lập lưu trữ tài khoản đã đăng ký
  List<UserAccount> _registeredUsers = [];

  void _handleSignIn() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Kiểm tra thông tin trùng khớp
    bool isSuccess = _registeredUsers.any(
            (user) => user.email == email && user.password == password);

    if (isSuccess) {
      _showSnackBar("Đăng nhập thành công!", Colors.green);
    } else {
      _showSnackBar("Thông tin không chính xác hoặc chưa đăng ký.", Colors.red);
    }
  }

  void _handleRegister() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Vui lòng nhập đầy đủ thông tin.", Colors.orange);
      return;
    }

    // Lưu tài khoản mới vào danh sách
    setState(() {
      _registeredUsers.add(UserAccount(email: email, password: password));
    });
    _showSnackBar("Đăng ký tài khoản thành công!", Colors.blue);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Email", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700])),
              SizedBox(height: 8),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Value",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
              SizedBox(height: 16),
              Text("Password", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700])),
              SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: true, // Ẩn mật khẩu
                decoration: InputDecoration(
                  hintText: "Value",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _handleSignIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF333333),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: Text("Sign in", style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF333333),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: Text("Register", style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}