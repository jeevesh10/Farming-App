import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';
import 'SubsistenceFarmingPage.dart';
import 'CommercialFarming.dart';
import 'OrganicFarming.dart';
import 'AquaponicsPage.dart';
import 'HydroponicsFarmingPage.dart';

class ManagementPage extends StatelessWidget {
  const ManagementPage({super.key});

  Future<void> _launchURL() async {
    const url = 'https://bloomranchofacton.com/pages/10-characteristics-of-subsistence-farming-primitive-intensive-examples-types-and-advantages';
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(languageService.translate('farming_management'), style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.orangeAccent,
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
                        languageService.translate('types_of_farming'),
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      buildFarmingType(
                        context,
                        languageService.translate('subsistence_farming'),
                        languageService.translate('subsistence_farming_desc'),
                        'assets/image/1.jpg',
                        languageService,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SubsistenceFarmingPage()),
                          );
                        },
                      ),
                      buildFarmingType(
                        context,
                        languageService.translate('commercial_farming'),
                        languageService.translate('commercial_farming_desc'),
                        'assets/image/2.jpg',
                        languageService,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CommercialFarmingPage()),
                          );
                        },
                      ),
                      buildFarmingType(
                        context,
                        languageService.translate('organic_farming'),
                        languageService.translate('organic_farming_desc'),
                        'assets/image/3.jpg',
                        languageService,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrganicFarmingPage()),
                          );
                        },
                      ),
                      buildFarmingType(
                        context,
                        languageService.translate('aquaponics'),
                        languageService.translate('aquaponics_desc'),
                        'assets/image/4.jpg',
                        languageService,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AquaponicsPage()),
                          );
                        },
                      ),
                      buildFarmingType(
                        context,
                        languageService.translate('hydroponics'),
                        languageService.translate('hydroponics_desc'),
                        'assets/image/5.jpg',
                        languageService,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HydroponicsFarmingPage()),
                          );
                        },
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

  Widget buildFarmingType(BuildContext context, String title, String description, String imagePath, LanguageService languageService, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(imagePath, width: 80, height: 80, fit: BoxFit.cover),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(description, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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