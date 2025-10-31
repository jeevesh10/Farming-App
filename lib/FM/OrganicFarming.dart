import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class OrganicFarmingPage extends StatelessWidget {
  const OrganicFarmingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(languageService.translate('organic_farming')),
            backgroundColor: Colors.green,
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
                        languageService.translate('organic_farming'),
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Image.asset("assets/image/3.jpg", width: double.infinity, height: 200, fit: BoxFit.cover),
                      const SizedBox(height: 10),
                      Text(
                        languageService.translate('organic_farming_description'),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        languageService.translate('key_features_organic_farming'),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        languageService.translate('organic_farming_features'),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        languageService.translate('advantages_organic_farming'),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        languageService.translate('organic_farming_advantages'),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        languageService.translate('disadvantages_organic_farming'),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        languageService.translate('organic_farming_disadvantages'),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        languageService.translate('usefulness_organic_farming'),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        languageService.translate('organic_farming_usefulness'),
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
