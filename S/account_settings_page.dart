import 'package:flutter/material.dart';
import 'login_page.dart'; // Import LoginPage for navigation
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class AccountSettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const AccountSettingsPage({super.key, required this.isDarkMode, required this.onThemeChanged});

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  late bool _isDarkMode;
  final String _selectedTheme = 'Light'; // Default theme

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) => Scaffold(
      appBar: AppBar(
        title: Text(languageService.translate('account'), style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: _isDarkMode ? Colors.black : Colors.orangeAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          ListTile(
            leading: Icon(Icons.person, color: Colors.blueAccent),
            title: Text(languageService.translate('profile')),
            onTap: () {
              // Navigate to profile information page
            },
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.email, color: Colors.greenAccent),
            title: Text(languageService.translate('email')),
            onTap: () {
              // Navigate to email settings page
            },
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.lock, color: Colors.purpleAccent),
            title: Text(languageService.translate('password')),
            onTap: () {
              // Navigate to change password page
            },
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.notifications, color: _isDarkMode ? Colors.yellow : Colors.grey),
            title: Text(languageService.translate('notifications')),
            onTap: () {
              // Navigate to notification settings page
            },
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.delete, color: Colors.redAccent),
            title: Text(languageService.translate('account')),
            onTap: () {
              // Navigate to account deletion page
            },
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(languageService.translate('logout')),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to LoginPage
              );
            },
          ),
        ],
      ),
    ),
    );
  }
}
