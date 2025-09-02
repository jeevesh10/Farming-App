import 'package:flutter/material.dart';
import 'S/../login_page.dart'; // Import LoginPage for navigation
import 'S/../account_settings_page.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';
import '../widgets/language_selector.dart';

class SettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const SettingsPage(
      {super.key, required this.isDarkMode, required this.onThemeChanged});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _isDarkMode;
  bool _notificationsEnabled = true; // Default notifications ON
  bool _autoUpdateEnabled = false; // Default auto update OFF
  bool _betaFeaturesEnabled = false; // Default beta features OFF
  bool _highContrastEnabled = false; // Default high contrast OFF
  bool _hapticFeedbackEnabled = true; // Default haptic feedback ON
  bool _soundEffectsEnabled = true; // Default sound effects ON
  bool _batteryOptimizationEnabled = true; // Default battery optimization ON
  bool _backgroundRefreshEnabled = false; // Default background refresh OFF
  bool _locationServicesEnabled = false; // Default location services OFF
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return Scaffold(
          backgroundColor: _isDarkMode ? Colors.black87 : Colors.white,
          appBar: AppBar(
            title: Text(
              languageService.translate('settings'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            backgroundColor: _isDarkMode ? Colors.black : Colors.orangeAccent,
            iconTheme:
                IconThemeData(color: _isDarkMode ? Colors.white : Colors.black),
            actions: [
              IconButton(
                icon: const Icon(Icons.language),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const LanguageSelector(),
                  );
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // General Settings Section
              _buildSectionHeader(
                languageService.translate('general_settings'),
                Icons.settings,
                Colors.blue,
              ),
              ListTile(
                leading: Icon(Icons.dark_mode,
                    color: _isDarkMode ? Colors.yellow : Colors.grey),
                title: Text(
                  languageService.translate('dark_mode'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                trailing: Switch(
                  value: _isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      _isDarkMode = value;
                    });
                    widget.onThemeChanged(value);
                  },
                  activeColor: Colors.orangeAccent,
                ),
              ),
              ListTile(
                leading: Icon(Icons.language, color: Colors.green),
                title: Text(
                  languageService.translate('language'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                subtitle: Text(
                  _selectedLanguage,
                  style: TextStyle(
                      color: _isDarkMode ? Colors.grey : Colors.black54),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const LanguageSelector(),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.update, color: Colors.purple),
                title: Text(
                  languageService.translate('auto_update'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                trailing: Switch(
                  value: _autoUpdateEnabled,
                  onChanged: (value) {
                    setState(() {
                      _autoUpdateEnabled = value;
                    });
                  },
                  activeColor: Colors.orangeAccent,
                ),
              ),

              const SizedBox(height: 20),

              // Display Settings Section
              _buildSectionHeader(
                languageService.translate('display_settings'),
                Icons.display_settings,
                Colors.orange,
              ),
              ListTile(
                leading: Icon(Icons.contrast, color: Colors.indigo),
                title: Text(
                  languageService.translate('high_contrast'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                trailing: Switch(
                  value: _highContrastEnabled,
                  onChanged: (value) {
                    setState(() {
                      _highContrastEnabled = value;
                    });
                  },
                  activeColor: Colors.orangeAccent,
                ),
              ),
              ListTile(
                leading: Icon(Icons.text_fields, color: Colors.teal),
                title: Text(
                  languageService.translate('font_size'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                subtitle: Text(
                  'Medium',
                  style: TextStyle(
                      color: _isDarkMode ? Colors.grey : Colors.black54),
                ),
                onTap: () {
                  _showFontSizeDialog(context, languageService);
                },
              ),

              const SizedBox(height: 20),

              // Notification Settings Section
              _buildSectionHeader(
                languageService.translate('notification_settings'),
                Icons.notifications,
                Colors.red,
              ),
              ListTile(
                leading: Icon(Icons.notifications,
                    color: _notificationsEnabled ? Colors.green : Colors.redAccent),
                title: Text(
                  languageService.translate('notifications'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                trailing: Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                  activeColor: Colors.orangeAccent,
                ),
              ),
              ListTile(
                leading: Icon(Icons.vibration, color: Colors.amber),
                title: Text(
                  languageService.translate('haptic_feedback'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                trailing: Switch(
                  value: _hapticFeedbackEnabled,
                  onChanged: (value) {
                    setState(() {
                      _hapticFeedbackEnabled = value;
                    });
                  },
                  activeColor: Colors.orangeAccent,
                ),
              ),
              ListTile(
                leading: Icon(Icons.volume_up, color: Colors.blue),
                title: Text(
                  languageService.translate('sound_effects'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                trailing: Switch(
                  value: _soundEffectsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _soundEffectsEnabled = value;
                    });
                  },
                  activeColor: Colors.orangeAccent,
                ),
              ),

              const SizedBox(height: 20),

              // Privacy & Security Section
              _buildSectionHeader(
                languageService.translate('privacy_settings'),
                Icons.security,
                Colors.green,
              ),
              ListTile(
                leading: Icon(Icons.location_on, color: Colors.blue),
                title: Text(
                  languageService.translate('location_services'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                trailing: Switch(
                  value: _locationServicesEnabled,
                  onChanged: (value) {
                    setState(() {
                      _locationServicesEnabled = value;
                    });
                  },
                  activeColor: Colors.orangeAccent,
                ),
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.purple),
                title: Text(
                  languageService.translate('camera_permission'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                onTap: () {
                  _showPermissionDialog(context, languageService, 'camera');
                },
              ),
              ListTile(
                leading: Icon(Icons.mic, color: Colors.orange),
                title: Text(
                  languageService.translate('microphone_permission'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                onTap: () {
                  _showPermissionDialog(context, languageService, 'microphone');
                },
              ),

              const SizedBox(height: 20),

              // Performance & Storage Section
              _buildSectionHeader(
                languageService.translate('storage_info'),
                Icons.storage,
                Colors.brown,
              ),
              ListTile(
                leading: Icon(Icons.battery_charging_full, color: Colors.green),
                title: Text(
                  languageService.translate('battery_optimization'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                trailing: Switch(
                  value: _batteryOptimizationEnabled,
                  onChanged: (value) {
                    setState(() {
                      _batteryOptimizationEnabled = value;
                    });
                  },
                  activeColor: Colors.orangeAccent,
                ),
              ),
              ListTile(
                leading: Icon(Icons.refresh, color: Colors.blue),
                title: Text(
                  languageService.translate('background_app_refresh'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                trailing: Switch(
                  value: _backgroundRefreshEnabled,
                  onChanged: (value) {
                    setState(() {
                      _backgroundRefreshEnabled = value;
                    });
                  },
                  activeColor: Colors.orangeAccent,
                ),
              ),
              ListTile(
                leading: Icon(Icons.cleaning_services, color: Colors.red),
                title: Text(
                  languageService.translate('clear_cache'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                onTap: () {
                  _showClearCacheDialog(context, languageService);
                },
              ),

              const SizedBox(height: 20),

              // App Information Section
              _buildSectionHeader(
                languageService.translate('about_app'),
                Icons.info,
                Colors.cyan,
              ),
              ListTile(
                leading: Icon(Icons.app_settings_alt, color: Colors.blue),
                title: Text(
                  languageService.translate('app_version'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                subtitle: Text(
                  '1.0.0',
                  style: TextStyle(
                      color: _isDarkMode ? Colors.grey : Colors.black54),
                ),
              ),
              ListTile(
                leading: Icon(Icons.build, color: Colors.grey),
                title: Text(
                  languageService.translate('build_number'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                subtitle: Text(
                  '2024.1',
                  style: TextStyle(
                      color: _isDarkMode ? Colors.grey : Colors.black54),
                ),
              ),
              ListTile(
                leading: Icon(Icons.rate_review, color: Colors.amber),
                title: Text(
                  languageService.translate('rate_app'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                onTap: () {
                  _showRateAppDialog(context, languageService);
                },
              ),
              ListTile(
                leading: Icon(Icons.share, color: Colors.green),
                title: Text(
                  languageService.translate('share_app'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                onTap: () {
                  _showShareAppDialog(context, languageService);
                },
              ),

              const SizedBox(height: 20),

              // Account & Support Section
              _buildSectionHeader(
                languageService.translate('account'),
                Icons.account_circle,
                Colors.purple,
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.teal),
                title: Text(
                  languageService.translate('profile'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountSettingsPage(
                        isDarkMode: _isDarkMode,
                        onThemeChanged: widget.onThemeChanged,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.help_outline, color: Colors.blue),
                title: Text(
                  languageService.translate('help'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                onTap: () {
                  _showHelpDialog(context, languageService);
                },
              ),
              ListTile(
                leading: Icon(Icons.feedback, color: Colors.orange),
                title: Text(
                  languageService.translate('feedback'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                onTap: () {
                  _showFeedbackDialog(context, languageService);
                },
              ),
              ListTile(
                leading: Icon(Icons.bug_report, color: Colors.red),
                title: Text(
                  languageService.translate('report_bug'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                onTap: () {
                  _showReportBugDialog(context, languageService);
                },
              ),

              const SizedBox(height: 20),

              // Logout Section
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text(
                  languageService.translate('logout'),
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                onTap: () {
                  _showLogoutDialog(context, languageService);
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _showFontSizeDialog(
      BuildContext context, LanguageService languageService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(languageService.translate('font_size')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Small'),
              onTap: () {
                Navigator.pop(context);
                // Implement font size change
              },
            ),
            ListTile(
              title: Text('Medium'),
              onTap: () {
                Navigator.pop(context);
                // Implement font size change
              },
            ),
            ListTile(
              title: Text('Large'),
              onTap: () {
                Navigator.pop(context);
                // Implement font size change
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(languageService.translate('cancel')),
          ),
        ],
      ),
    );
  }

  void _showPermissionDialog(BuildContext context,
      LanguageService languageService, String permission) {
    final String titleKey = permission == 'camera'
        ? 'camera_permission'
        : permission == 'microphone'
            ? 'microphone_permission'
            : 'storage_permission';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(languageService.translate(titleKey)),
        content: Text('Manage $permission permissions in device settings.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(languageService.translate('cancel')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to device settings
            },
            child: Text(languageService.translate('ok')),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog(
      BuildContext context, LanguageService languageService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(languageService.translate('clear_cache')),
        content: const Text('This will clear all cached data. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(languageService.translate('cancel')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement cache clearing
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully')),
              );
            },
            child: Text(languageService.translate('ok')),
          ),
        ],
      ),
    );
  }

  void _showRateAppDialog(
      BuildContext context, LanguageService languageService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(languageService.translate('rate_app')),
        content: const Text(
            'Rate our app on the app store to help other users.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(languageService.translate('cancel')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement app store rating
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening app store...')),
              );
            },
            child: Text(languageService.translate('ok')),
          ),
        ],
      ),
    );
  }

  void _showShareAppDialog(
      BuildContext context, LanguageService languageService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(languageService.translate('share_app')),
        content:
            const Text('Share this app with your friends and family.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(languageService.translate('cancel')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement app sharing
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening share options...')),
              );
            },
            child: Text(languageService.translate('ok')),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(
      BuildContext context, LanguageService languageService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(languageService.translate('help')),
        content: const Text(
            'Need help? Contact our support team or check our FAQ section.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(languageService.translate('ok')),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDialog(
      BuildContext context, LanguageService languageService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(languageService.translate('feedback')),
        content: const Text(
            'We value your feedback. Please share your thoughts with us.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(languageService.translate('cancel')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement feedback submission
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening feedback form...')),
              );
            },
            child: Text(languageService.translate('ok')),
          ),
        ],
      ),
    );
  }

  void _showReportBugDialog(
      BuildContext context, LanguageService languageService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(languageService.translate('report_bug')),
        content: const Text('Found a bug? Help us improve by reporting it.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(languageService.translate('cancel')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement bug reporting
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening bug report form...')),
              );
            },
            child: Text(languageService.translate('ok')),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(
      BuildContext context, LanguageService languageService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(languageService.translate('logout')),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(languageService.translate('cancel')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text(languageService.translate('logout')),
          ),
        ],
      ),
    );
  }
}
