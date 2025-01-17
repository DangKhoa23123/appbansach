import 'package:flutter/material.dart';
import 'package:ungdungthuetro/Login%20and%20Register/Register.dart';
import 'package:ungdungthuetro/pages/Homepage/Home.dart';
import 'package:ungdungthuetro/pages/Screenmain.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Logo.png',width: 100,height: 100,),
              SizedBox(height: 10,),
            // Email
            TextField(
              decoration: InputDecoration(
                labelText: "Tên người dùng",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),
            // Mật khẩu
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Mật khẩu",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Mainscreen()),
                    );
                  },
              child: Text("Đăng nhập"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 16),
            // Chuyển đến màn hình đăng ký
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Chưa có tài khoản?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Register()),
                    );
                  },
                  child: Text("Đăng ký"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
