import 'package:flutter/material.dart';
import 'login.dart'; // Import màn hình đăng nhập
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false; // Trạng thái loading

  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar("Mật khẩu xác nhận không khớp", Colors.red);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://192.168.99.113:3000/auth/register'), // Đổi thành IP nếu test trên thiết bị thật
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": _usernameController.text,
          "phone": _phoneController.text,
          "email": _emailController.text,
          "password": _passwordController.text,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success']) {
        _showSnackBar("Đăng ký thành công!", Colors.green);
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login(
                username: _usernameController.text,
                password: _passwordController.text,
              ),
            ),
          );
        });
      } else {
        _showSnackBar(responseData['error'], Colors.red);
      }
    } catch (e) {
      _showSnackBar("Lỗi kết nối server!", Colors.red);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Logo.png', width: 120, height: 120),
            SizedBox(height: 20),
            _buildTextField("Tên người dùng", Icons.person, _usernameController),
            SizedBox(height: 12),
            _buildTextField("Số điện thoại", Icons.phone, _phoneController),
            SizedBox(height: 12),
            _buildTextField("Email", Icons.email, _emailController),
            SizedBox(height: 12),
            _buildTextField("Mật khẩu", Icons.lock, _passwordController, isPassword: true),
            SizedBox(height: 12),
            _buildTextField("Xác nhận mật khẩu", Icons.lock_outline, _confirmPasswordController, isPassword: true),
            SizedBox(height: 24),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 55)),
                    child: Text("Đăng ký", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Đã có tài khoản?"),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Đăng nhập"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
