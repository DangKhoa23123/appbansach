import 'package:flutter/material.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trợ giúp',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.white],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildSupportCard(
              icon: Icons.help_outline,
              title: 'Câu hỏi thường gặp',
              subtitle: 'Tìm câu trả lời nhanh cho các câu hỏi phổ biến',
            ),
            _buildSupportCard(
              icon: Icons.email_outlined,
              title: 'Liên hệ hỗ trợ',
              subtitle: 'Gửi email cho đội ngũ hỗ trợ của chúng tôi',
            ),
            _buildSupportCard(
              icon: Icons.phone_outlined,
              title: 'Hotline',
              subtitle: '1900 xxxx (8:00 - 22:00)',
            ),
            _buildSupportCard(
              icon: Icons.chat_bubble_outline,
              title: 'Chat với nhân viên',
              subtitle: 'Trò chuyện trực tiếp với đội ngũ hỗ trợ',
            ),
            _buildSupportCard(
              icon: Icons.policy_outlined,
              title: 'Điều khoản sử dụng',
              subtitle: 'Xem các điều khoản và điều kiện',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue.shade700),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            subtitle,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          // Xử lý khi người dùng nhấn vào mục hỗ trợ
        },
      ),
    );
  }
}
