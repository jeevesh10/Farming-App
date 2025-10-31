import 'package:flutter/material.dart';
import '../S/login_page.dart'; // Import LoginPage for navigation
import '../S/account_settings_page.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';
import '../services/sound_service.dart';
import '../services/font_service.dart';
import '../widgets/language_selector.dart';
import '../widgets/clickable_widget.dart';

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
    return Consumer3<LanguageService, SoundService, FontService>(
      builder: (context, languageService, soundService, fontService, child) {
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
                    builder: (context) => LanguageSelector(isDarkMode: _isDarkMode),
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
                    builder: (context) => LanguageSelector(isDarkMode: _isDarkMode),
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
              ClickableListTile(
                leading: Icon(Icons.text_fields, color: Colors.teal),
                title: Text(
                  languageService.translate('font_size'),
                  style: TextStyle(
                      fontSize: fontService.fontSize,
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                subtitle: Text(
                  fontService.getFontSizeLabel(languageService),
                  style: TextStyle(
                      fontSize: fontService.fontSize - 2,
                      color: _isDarkMode ? Colors.grey : Colors.black54),
                ),
                onTap: () {
                  _showFontSizeDialog(context, languageService, fontService);
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
              ClickableListTile(
                leading: Icon(Icons.volume_up, color: Colors.blue),
                title: Text(
                  languageService.translate('sound_effects'),
                  style: TextStyle(
                      fontSize: fontService.fontSize,
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                trailing: Switch(
                  value: soundService.soundEnabled,
                  onChanged: (value) {
                    soundService.setSoundEnabled(value);
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

              const SizedBox(height: 20),

              // Debug Section
              _buildSectionHeader(
                'DEBUG SECTION',
                Icons.bug_report,
                Colors.red,
              ),
              ListTile(
                leading: Icon(Icons.language, color: Colors.red),
                title: Text(
                  'DEBUG: Force Hindi',
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                onTap: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Forcing Hindi language...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  await languageService.debugForceLanguageChange('hi');
                },
              ),
              ListTile(
                leading: Icon(Icons.language, color: Colors.blue),
                title: Text(
                  'DEBUG: Force English',
                  style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
                ),
                onTap: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Forcing English language...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  await languageService.debugForceLanguageChange('en');
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

  void _showFontSizeDialog(BuildContext context, LanguageService languageService, FontService fontService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.white,
        title: Text(
          languageService.translate('font_size'),
          style: TextStyle(
            fontSize: fontService.titleFontSize,
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClickableListTile(
              title: Text(
                languageService.translate('small'), 
                style: TextStyle(
                  fontSize: 14.0,
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              trailing: fontService.currentFontSize == FontSizeOption.small 
                ? Icon(Icons.check, color: Colors.green) 
                : null,
              onTap: () {
                fontService.setFontSize(FontSizeOption.small);
                Navigator.pop(context);
              },
            ),
            ClickableListTile(
              title: Text(
                languageService.translate('medium'), 
                style: TextStyle(
                  fontSize: 16.0,
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              trailing: fontService.currentFontSize == FontSizeOption.medium 
                ? Icon(Icons.check, color: Colors.green) 
                : null,
              onTap: () {
                fontService.setFontSize(FontSizeOption.medium);
                Navigator.pop(context);
              },
            ),
            ClickableListTile(
              title: Text(
                languageService.translate('large'), 
                style: TextStyle(
                  fontSize: 20.0,
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              trailing: fontService.currentFontSize == FontSizeOption.large 
                ? Icon(Icons.check, color: Colors.green) 
                : null,
              onTap: () {
                fontService.setFontSize(FontSizeOption.large);
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          ClickableButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              languageService.translate('cancel'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
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
        backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.white,
        title: Text(
          languageService.translate(titleKey),
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        content: Text(
          'Manage $permission permissions in device settings.',
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        actions: [
          ClickableButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              languageService.translate('cancel'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          ClickableButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to device settings
            },
            child: Text(
              languageService.translate('ok'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
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
        backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.white,
        title: Text(
          languageService.translate('clear_cache'),
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        content: Text(
          'This will clear all cached data. Continue?',
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        actions: [
          ClickableButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              languageService.translate('cancel'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          ClickableButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement cache clearing
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Cache cleared successfully',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _isDarkMode ? Colors.grey[700] : Colors.black87,
                ),
              );
            },
            child: Text(
              languageService.translate('ok'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
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
        backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.white,
        title: Text(
          languageService.translate('rate_app'),
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        content: Text(
          'Rate our app on the app store to help other users.',
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        actions: [
          ClickableButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              languageService.translate('cancel'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          ClickableButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement app store rating
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Opening app store...',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _isDarkMode ? Colors.grey[700] : Colors.black87,
                ),
              );
            },
            child: Text(
              languageService.translate('ok'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
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
        backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.white,
        title: Text(
          languageService.translate('share_app'),
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        content: Text(
          'Share this app with your friends and family.',
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        actions: [
          ClickableButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              languageService.translate('cancel'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          ClickableButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement app sharing
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Opening share options...',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _isDarkMode ? Colors.grey[700] : Colors.black87,
                ),
              );
            },
            child: Text(
              languageService.translate('ok'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
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
        backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.white,
        title: Text(
          languageService.translate('help'),
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        content: Text(
          'Need help? Contact our support team or check our FAQ section.',
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        actions: [
          ClickableButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              languageService.translate('ok'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
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
        backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.white,
        title: Text(
          languageService.translate('feedback'),
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        content: Text(
          'We value your feedback. Please share your thoughts with us.',
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        actions: [
          ClickableButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              languageService.translate('cancel'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          ClickableButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement feedback submission
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Opening feedback form...',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _isDarkMode ? Colors.grey[700] : Colors.black87,
                ),
              );
            },
            child: Text(
              languageService.translate('ok'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
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
        backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.white,
        title: Text(
          languageService.translate('report_bug'),
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        content: Text(
          'Found a bug? Help us improve by reporting it.',
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        actions: [
          ClickableButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              languageService.translate('cancel'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          ClickableButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement bug reporting
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Opening bug report form...',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _isDarkMode ? Colors.grey[700] : Colors.black87,
                ),
              );
            },
            child: Text(
              languageService.translate('ok'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
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
        backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.white,
        title: Text(
          languageService.translate('logout'),
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        actions: [
          ClickableButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              languageService.translate('cancel'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          ClickableButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text(
              languageService.translate('logout'),
              style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
