import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ungdungthuetro/Login%20and%20Register/Register.dart';
import 'package:ungdungthuetro/pages/Screenmain.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  final String? username;
  final String? password;

  const Login({super.key, this.username, this.password});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username ?? "");
    _passwordController = TextEditingController(text: widget.password ?? "");
  }

  Future<void> _login() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin!"), backgroundColor: Colors.red),
      );
      return;
    }

    final url = Uri.parse('http://192.168.99.113:5000/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Đăng nhập thành công!"), backgroundColor: Colors.green),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Mainscreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Đăng nhập thất bại!"), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi kết nối đến server!"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Logo.png', width: 120, height: 120),
            SizedBox(height: 30),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Tên người dùng"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Mật khẩu"),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _login,
              child: Text("Đăng nhập"),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Register())),
              child: Text("Đăng ký"),
            ),
          ],
        ),
      ),
    );
  }
}
