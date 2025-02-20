import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ungdungthuetro/api_config.dart';
import 'package:ungdungthuetro/pages/Screenmain.dart';
import 'package:ungdungthuetro/Login%20and%20Register/Register.dart';
import 'package:ungdungthuetro/Login%20and%20Register/Forgotpassword.dart';
import 'package:ungdungthuetro/global.dart' as globals;

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
  bool _isLoading = false;  // Thêm biến để kiểm soát trạng thái loading

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username ?? "");
    _passwordController = TextEditingController(text: widget.password ?? "");
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin!"), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('${ApiConfig.baseUrl}/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      if (!mounted) return;

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        // Xử lý an toàn hơn với null check
        globals.globalUserName = data['user']?['username'] ?? _usernameController.text;

        if (!mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đăng nhập thành công!"), backgroundColor: Colors.green),
        );
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Mainscreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Đăng nhập thất bại!"), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lỗi kết nối đến server!"), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Image.asset('assets/Logo.png', width: 120, height: 120),
            const SizedBox(height: 30),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: "Tên người dùng",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Mật khẩu",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading 
                  ? const CircularProgressIndicator()
                  : const Text("Đăng nhập"),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Register())),
              child: const Text("Đăng ký"),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Forgotpassword())),
              child: const Text("Quên mật khẩu"),
            ),
          ],
        ),
      ),
    );
  }
}