import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class SoilManagementPage extends StatelessWidget {
  const SoilManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(languageService.translate('soil_management'), style: TextStyle(fontWeight: FontWeight.bold)),
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
                        languageService.translate('soil_ph_calculator'),
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      SoilPhCalculator(),
                      const SizedBox(height: 20),
                      Text(
                        languageService.translate('types_of_soil_farming'),
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      buildSoilType(
                        context,
                        languageService.translate('alluvial_soil'),
                        languageService.translate('alluvial_soil_desc'),
                        'assets/image/6.jpg',
                        languageService,
                      ),
                      buildSoilType(
                        context,
                        languageService.translate('black_soil'),
                        languageService.translate('black_soil_desc'),
                        'assets/image/7.jpg',
                        languageService,
                      ),
                      buildSoilType(
                        context,
                        languageService.translate('red_soil'),
                        languageService.translate('red_soil_desc'),
                        'assets/image/8.jpg',
                        languageService,
                      ),
                      buildSoilType(
                        context,
                        languageService.translate('laterite_soil'),
                        languageService.translate('laterite_soil_desc'),
                        'assets/image/9.jpg',
                        languageService,
                      ),
                      buildSoilType(
                        context,
                        languageService.translate('sandy_soil'),
                        languageService.translate('sandy_soil_desc'),
                        'assets/image/10.jpg',
                        languageService,
                      ),
                      buildSoilType(
                        context,
                        languageService.translate('clayey_soil'),
                        languageService.translate('clayey_soil_desc'),
                        'assets/image/11.jpg',
                        languageService,
                      ),
                      buildSoilType(
                        context,
                        languageService.translate('loamy_soil'),
                        languageService.translate('loamy_soil_desc'),
                        'assets/image/12.jpg',
                        languageService,
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

  Widget buildSoilType(BuildContext context, String title, String description, String imagePath, LanguageService languageService) {
    return Card(
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
    );
  }
}

class SoilPhCalculator extends StatefulWidget {
  const SoilPhCalculator({super.key});

  @override
  _SoilPhCalculatorState createState() => _SoilPhCalculatorState();
}

class _SoilPhCalculatorState extends State<SoilPhCalculator> {
  final TextEditingController _phController = TextEditingController();
  String _recommendation = "";

  void _calculateRecommendation() {
    double? ph = double.tryParse(_phController.text);
    if (ph == null) {
      final languageService = Provider.of<LanguageService>(context, listen: false);
      setState(() {
        _recommendation = languageService.translate('enter_valid_ph');
      });
      return;
    }

    if (ph < 5.5) {
      final languageService = Provider.of<LanguageService>(context, listen: false);
      _recommendation = languageService.translate('soil_too_acidic');
    } else if (ph >= 5.5 && ph <= 7.5) {
      final languageService = Provider.of<LanguageService>(context, listen: false);
      _recommendation = languageService.translate('soil_ph_ideal');
    } else {
      final languageService = Provider.of<LanguageService>(context, listen: false);
      _recommendation = languageService.translate('soil_too_alkaline');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageService.translate('enter_soil_ph_value'),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _phController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: languageService.translate('enter_ph_value_hint'),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _calculateRecommendation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(languageService.translate('check_soil_condition')),
                ),
                const SizedBox(height: 10),
                Text(
                  _recommendation,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
