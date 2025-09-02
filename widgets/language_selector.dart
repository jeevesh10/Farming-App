import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return AlertDialog(
          title: Text(languageService.translate('select_language')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Radio<String>(
                  value: 'en',
                  groupValue: languageService.currentLocale.languageCode,
                  onChanged: (value) async {
                    print('English selected');
                    await languageService.changeLanguage(value!);
                    await languageService.testTranslations();
                    if (context.mounted) {
                      Navigator.pop(context);
                      // Force rebuild of the entire app
                      (context as Element).markNeedsBuild();
                    }
                  },
                ),
                title: Text(languageService.translate('english')),
                onTap: () async {
                  print('English tapped');
                  await languageService.changeLanguage('en');
                  await languageService.testTranslations();
                  if (context.mounted) {
                    Navigator.pop(context);
                    // Force rebuild of the entire app
                    (context as Element).markNeedsBuild();
                  }
                },
              ),
              ListTile(
                leading: Radio<String>(
                  value: 'hi',
                  groupValue: languageService.currentLocale.languageCode,
                  onChanged: (value) async {
                    print('Hindi selected');
                    await languageService.changeLanguage(value!);
                    await languageService.testTranslations();
                    if (context.mounted) {
                      Navigator.pop(context);
                      // Force rebuild of the entire app
                      (context as Element).markNeedsBuild();
                    }
                  },
                ),
                title: Text(languageService.translate('hindi')),
                onTap: () async {
                  print('Hindi tapped');
                  await languageService.changeLanguage('hi');
                  await languageService.testTranslations();
                  if (context.mounted) {
                    Navigator.pop(context);
                    // Force rebuild of the entire app
                    (context as Element).markNeedsBuild();
                  }
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
        );
      },
    );
  }
}


