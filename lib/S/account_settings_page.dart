import 'package:flutter/material.dart';
import 'login_page.dart'; // Import LoginPage for navigation
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/language_service.dart';
import '../services/font_service.dart';
import '../widgets/clickable_widget.dart';
import '../widgets/clickable_tab_bar.dart';

class AccountSettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const AccountSettingsPage(
      {super.key, required this.isDarkMode, required this.onThemeChanged});

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage>
    with SingleTickerProviderStateMixin {
  late bool _isDarkMode;
  late TabController _tabController;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageService, FontService>(
      builder: (context, languageService, fontService, child) => Scaffold(
        backgroundColor: _isDarkMode ? Colors.black87 : Colors.white,
        appBar: AppBar(
          title: Text(
            languageService.translate('account'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontService.titleFontSize,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          backgroundColor: _isDarkMode ? Colors.black : Colors.orangeAccent,
          iconTheme:
              IconThemeData(color: _isDarkMode ? Colors.white : Colors.black),
          bottom: ClickableTabBar(
            controller: _tabController,
            labelColor: _isDarkMode ? Colors.white : Colors.black,
            unselectedLabelColor: _isDarkMode ? Colors.grey : Colors.black54,
            tabs: [
              Tab(
                icon: Icon(Icons.person),
                child: Text(
                  languageService.translate('profile'),
                  style: TextStyle(fontSize: fontService.fontSize - 2),
                ),
              ),
              Tab(
                icon: Icon(Icons.security),
                child: Text(
                  languageService.translate('security'),
                  style: TextStyle(fontSize: fontService.fontSize - 2),
                ),
              ),
              Tab(
                icon: Icon(Icons.settings),
                child: Text(
                  languageService.translate('preferences'),
                  style: TextStyle(fontSize: fontService.fontSize - 2),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildProfileTab(languageService, fontService),
            _buildSecurityTab(languageService, fontService),
            _buildPreferencesTab(languageService, fontService),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTab(
      LanguageService languageService, FontService fontService) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.orangeAccent,
                backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null
                    ? Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      )
                    : null,
              ),
              SizedBox(height: 16),
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: fontService.headingFontSize,
                  fontWeight: FontWeight.bold,
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'john.doe@example.com',
                style: TextStyle(
                  fontSize: fontService.fontSize,
                  color: _isDarkMode ? Colors.grey : Colors.black54,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 32),
        ClickableListTile(
          leading: Icon(Icons.edit, color: Colors.blueAccent),
          title: Text(
            languageService.translate('edit_profile'),
            style: TextStyle(
              fontSize: fontService.fontSize,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          onTap: () {
            _showEditProfileDialog(languageService, fontService);
          },
        ),
        Divider(),
        ClickableListTile(
          leading: Icon(Icons.photo_camera, color: Colors.greenAccent),
          title: Text(
            languageService.translate('change_profile_picture'),
            style: TextStyle(
              fontSize: fontService.fontSize,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          onTap: () {
            _showImagePickerDialog(languageService, fontService);
          },
        ),
      ],
    );
  }

  Widget _buildSecurityTab(
      LanguageService languageService, FontService fontService) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        ClickableListTile(
          leading: Icon(Icons.lock_outline, color: Colors.purpleAccent),
          title: Text(
            languageService.translate('change_password'),
            style: TextStyle(
              fontSize: fontService.fontSize,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          subtitle: Text(
            'Last changed 30 days ago',
            style: TextStyle(
              fontSize: fontService.fontSize - 2,
              color: _isDarkMode ? Colors.grey : Colors.black54,
            ),
          ),
          onTap: () {
            _showChangePasswordDialog(languageService, fontService);
          },
        ),
        Divider(),
        ClickableListTile(
          leading: Icon(Icons.fingerprint, color: Colors.amber),
          title: Text(
            'Biometric Authentication',
            style: TextStyle(
              fontSize: fontService.fontSize,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          trailing: Switch(
            value: true,
            onChanged: (value) {
              // Implement biometric toggle
            },
            activeColor: Colors.orangeAccent,
          ),
        ),
        Divider(),
        ClickableListTile(
          leading: Icon(Icons.phone_android, color: Colors.teal),
          title: Text(
            'Two-Factor Authentication',
            style: TextStyle(
              fontSize: fontService.fontSize,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          trailing: Switch(
            value: false,
            onChanged: (value) {
              // Implement 2FA toggle
            },
            activeColor: Colors.orangeAccent,
          ),
        ),
      ],
    );
  }

  Widget _buildPreferencesTab(
      LanguageService languageService, FontService fontService) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        ClickableListTile(
          leading: Icon(Icons.notifications_outlined, color: Colors.blue),
          title: Text(
            languageService.translate('notification_preferences'),
            style: TextStyle(
              fontSize: fontService.fontSize,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          onTap: () {
            // Navigate to notification preferences
          },
        ),
        Divider(),
        ClickableListTile(
          leading: Icon(Icons.privacy_tip_outlined, color: Colors.green),
          title: Text(
            'Privacy Settings',
            style: TextStyle(
              fontSize: fontService.fontSize,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          onTap: () {
            // Navigate to privacy settings
          },
        ),
        Divider(),
        ClickableListTile(
          leading: Icon(Icons.download_outlined, color: Colors.purple),
          title: Text(
            'Data Export',
            style: TextStyle(
              fontSize: fontService.fontSize,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          onTap: () {
            _showDataExportDialog(languageService, fontService);
          },
        ),
        Divider(),
        ClickableListTile(
          leading: Icon(Icons.delete_forever, color: Colors.redAccent),
          title: Text(
            'Delete Account',
            style: TextStyle(
              fontSize: fontService.fontSize,
              color: Colors.redAccent,
            ),
          ),
          onTap: () {
            _showDeleteAccountDialog(languageService, fontService);
          },
        ),
        SizedBox(height: 32),
        ClickableListTile(
          leading: Icon(Icons.logout, color: Colors.red),
          title: Text(
            languageService.translate('logout'),
            style: TextStyle(
              fontSize: fontService.fontSize,
              color: Colors.red,
            ),
          ),
          onTap: () {
            _showLogoutDialog(languageService, fontService);
          },
        ),
      ],
    );
  }

  void _showEditProfileDialog(
      LanguageService languageService, FontService fontService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit Profile',
          style: TextStyle(fontSize: fontService.titleFontSize),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                labelStyle: TextStyle(fontSize: fontService.fontSize),
              ),
              style: TextStyle(fontSize: fontService.fontSize),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(fontSize: fontService.fontSize),
              ),
              style: TextStyle(fontSize: fontService.fontSize),
            ),
          ],
        ),
        actions: [
          ClickableButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ClickableButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement save profile
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(
      LanguageService languageService, FontService fontService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Change Password',
          style: TextStyle(fontSize: fontService.titleFontSize),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
                labelStyle: TextStyle(fontSize: fontService.fontSize),
              ),
              style: TextStyle(fontSize: fontService.fontSize),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                labelStyle: TextStyle(fontSize: fontService.fontSize),
              ),
              style: TextStyle(fontSize: fontService.fontSize),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                labelStyle: TextStyle(fontSize: fontService.fontSize),
              ),
              style: TextStyle(fontSize: fontService.fontSize),
            ),
          ],
        ),
        actions: [
          ClickableButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ClickableButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement password change
            },
            child: Text('Change'),
          ),
        ],
      ),
    );
  }

  void _showDataExportDialog(
      LanguageService languageService, FontService fontService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Export Data',
          style: TextStyle(fontSize: fontService.titleFontSize),
        ),
        content: Text(
          'This will export all your data to a downloadable file. Continue?',
          style: TextStyle(fontSize: fontService.fontSize),
        ),
        actions: [
          ClickableButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ClickableButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement data export
            },
            child: Text('Export'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(
      LanguageService languageService, FontService fontService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Account',
          style:
              TextStyle(fontSize: fontService.titleFontSize, color: Colors.red),
        ),
        content: Text(
          'This action cannot be undone. All your data will be permanently deleted.',
          style: TextStyle(fontSize: fontService.fontSize),
        ),
        actions: [
          ClickableButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ClickableButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement account deletion
            },
            backgroundColor: Colors.red,
            child: Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(
      LanguageService languageService, FontService fontService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          languageService.translate('logout'),
          style: TextStyle(fontSize: fontService.titleFontSize),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyle(fontSize: fontService.fontSize),
        ),
        actions: [
          ClickableButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ClickableButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showImagePickerDialog(
      LanguageService languageService, FontService fontService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.white,
        title: Text(
          languageService.translate('change_profile_picture'),
          style: TextStyle(
            fontSize: fontService.titleFontSize,
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClickableListTile(
              leading: Icon(Icons.photo_library, color: Colors.blue),
              title: Text(
                languageService.translate('gallery'),
                style: TextStyle(
                  fontSize: fontService.fontSize,
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              onTap: () async {
                Navigator.pop(context);
                await _pickImageFromGallery();
              },
            ),
            ClickableListTile(
              leading: Icon(Icons.camera_alt, color: Colors.green),
              title: Text(
                languageService.translate('camera'),
                style: TextStyle(
                  fontSize: fontService.fontSize,
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              onTap: () async {
                Navigator.pop(context);
                await _pickImageFromCamera();
              },
            ),
          ],
        ),
        actions: [
          ClickableButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              languageService.translate('cancel'),
              style:
                  TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
        });
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
        });
      }
    } catch (e) {
      print('Error picking image from camera: $e');
    }
  }
}
