import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class HydroponicsFarmingPage extends StatelessWidget {
  const HydroponicsFarmingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(languageService.translate('hydroponics')),
            backgroundColor: Colors.purple,
          ),
          body: Stack(
            children: [
              Center(
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset("assets/image/logo.png", width: 200, height: 200),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        languageService.translate('hydroponics'),
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Image.asset("assets/image/5.jpg", width: double.infinity, height: 200, fit: BoxFit.cover),
                      const SizedBox(height: 10),
                      Text(
                        languageService.translate('hydroponics_description'),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        languageService.translate('key_features_hydroponics'),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        languageService.translate('hydroponics_features'),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        languageService.translate('advantages_hydroponics'),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        languageService.translate('hydroponics_advantages'),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        languageService.translate('disadvantages_hydroponics'),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        languageService.translate('hydroponics_disadvantages'),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        languageService.translate('usefulness_hydroponics'),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        languageService.translate('hydroponics_usefulness'),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
