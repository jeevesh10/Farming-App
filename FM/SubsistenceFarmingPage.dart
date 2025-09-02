import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class SubsistenceFarmingPage extends StatelessWidget {
  const SubsistenceFarmingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(languageService.translate('subsistence_farming')),
            backgroundColor: Colors.redAccent,
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
                        languageService.translate('subsistence_farming'),
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        languageService.translate('subsistence_farming_description'),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        languageService.translate('sustainable_farming'),
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Image.asset("assets/image/1.jpg", width: double.infinity, height: 200, fit: BoxFit.cover),
                      const SizedBox(height: 10),
                      Text(
                        languageService.translate('sustainable_farming_description'),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        languageService.translate('key_features_sustainable_farming'),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        languageService.translate('sustainable_farming_features'),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        languageService.translate('advantages_sustainable_farming'),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        languageService.translate('sustainable_farming_advantages'),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        languageService.translate('disadvantages_sustainable_farming'),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        languageService.translate('sustainable_farming_disadvantages'),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        languageService.translate('usefulness_sustainable_farming'),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        languageService.translate('sustainable_farming_usefulness'),
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

  Future<bool> canLaunchUrl(Uri uri) async {
    return await canLaunch(uri.toString());
  }

  Future<void> launchUrl(Uri uri) async {
    await launch(uri.toString());
  }

  canLaunch(String string) {}

  launch(String string) {}
}