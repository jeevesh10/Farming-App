import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class LanguageSelector extends StatelessWidget {
  final bool isDarkMode;
  
  const LanguageSelector({Key? key, this.isDarkMode = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return AlertDialog(
          backgroundColor: isDarkMode ? Colors.grey[800] : Colors.white,
          title: Text(
            languageService.translate('select_language'),
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Radio<String>(
                  value: 'en',
                  groupValue: languageService.currentLocale.languageCode,
                  onChanged: (value) async {
                    if (value != null) {
                      await languageService.changeLanguage(value);
                      Navigator.pop(context);
                    }
                  },
                ),
                title: Text(
                  languageService.translate('english'),
                  style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                ),
                onTap: () async {
                  await languageService.changeLanguage('en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Radio<String>(
                  value: 'hi',
                  groupValue: languageService.currentLocale.languageCode,
                  onChanged: (value) async {
                    if (value != null) {
                      await languageService.changeLanguage(value);
                      Navigator.pop(context);
                    }
                  },
                ),
                title: Text(
                  languageService.translate('hindi'),
                  style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                ),
                onTap: () async {
                  await languageService.changeLanguage('hi');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                languageService.translate('cancel'),
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}


