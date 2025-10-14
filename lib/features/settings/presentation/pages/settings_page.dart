import 'package:flutter/material.dart';

/// صفحة الإعدادات المبسطة
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false; // سيتم ربطه بـ ThemeMode لاحقاً

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('الوضع الداكن'),
            subtitle: const Text('تفعيل الوضع الليلي'),
            value: _isDarkMode,
            onChanged: (value) {
              setState(() => _isDarkMode = value);
              // TODO: تطبيق تغيير الثيم
            },
            secondary: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
          ),
        ],
      ),
    );
  }
}
