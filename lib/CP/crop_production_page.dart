import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class CropProductionPage extends StatefulWidget {
  const CropProductionPage({super.key});

  @override
  _CropProductionPageState createState() => _CropProductionPageState();
}

class _CropProductionPageState extends State<CropProductionPage> {
  final TextEditingController _areaController = TextEditingController();
  String selectedUnit = 'acres'; // Use language key instead of English text
  String selectedCrop = 'Wheat';
  double? resultKg;

  final Map<String, double> cropYieldsPerAcre = {
    'Wheat': 45.0,
    'Rice': 50.0,
    'Corn': 180.0,
    'Soybeans': 50.0,
    'Cotton': 800.0,
    'Sugarcane': 8000.0,
    'Potatoes': 400.0,
    'Tomatoes': 25.0,
    'Onions': 200.0,
    'Carrots': 300.0,
  };

  String _cropNameToTranslationKey(String cropName) {
    switch (cropName) {
      case 'Wheat':
        return 'wheat';
      case 'Rice':
        return 'rice';
      case 'Corn':
        return 'corn';
      case 'Soybeans':
        return 'soybeans';
      case 'Cotton':
        return 'cotton';
      case 'Sugarcane':
        return 'sugarcane';
      case 'Potatoes':
        return 'potatoes';
      case 'Tomatoes':
        return 'tomatoes';
      case 'Onions':
        return 'onions';
      case 'Carrots':
        return 'carrots';
      default:
        return cropName;
    }
  }

  // Language keys for units
  final List<String> unitKeys = ['acres', 'hectares'];

  void calculateProduction() {
    final area = double.tryParse(_areaController.text);
    if (area == null || area <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid area')),
      );
      return;
    }

    final yieldPerAcre = cropYieldsPerAcre[selectedCrop] ?? 0.0;
    double calculatedYield;

    if (selectedUnit == 'acres') {
      calculatedYield = area * yieldPerAcre;
    } else {
      // Convert hectares to acres (1 hectare = 2.471 acres)
      calculatedYield = area * 2.471 * yieldPerAcre;
    }

    setState(() {
      resultKg = calculatedYield;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Verify that we have access to the language service
    final languageService = Provider.of<LanguageService>(context, listen: false);
    print('CropProductionPage - Provider check: ${languageService.currentLocale.languageCode}');
    
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        // Wait for language service to be initialized
        if (!languageService.isInitialized) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final isDark = Theme.of(context).brightness == Brightness.dark;
        final textTheme = Theme.of(context).textTheme;

        // Debug: Print current language and translations
        print('CropProductionPage - Current language: ${languageService.currentLocale.languageCode}');
        print('CropProductionPage - crop_production_calculator: ${languageService.translate('crop_production_calculator')}');
        print('CropProductionPage - enter_land_area: ${languageService.translate('enter_land_area')}');

        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(languageService.translate('crop_production_calculator'), style: textTheme.titleLarge),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.orange[400] : Colors.orange[200],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)],
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _areaController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: languageService.translate('enter_land_area'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedUnit,
                              items: unitKeys
                                  .map((e) =>
                                      DropdownMenuItem(value: e, child: Text(languageService.translate(e))))
                                  .toList(),
                              onChanged: (val) {
                                setState(() => selectedUnit = val!);
                              },
                              decoration: InputDecoration(
                                labelText: languageService.translate('select_unit'),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedCrop,
                              items: cropYieldsPerAcre.keys
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(languageService.translate(_cropNameToTranslationKey(e))),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() => selectedCrop = val!);
                              },
                              decoration: InputDecoration(
                                labelText: languageService.translate('select_crop'),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: calculateProduction,
                        icon: Icon(Icons.calculate),
                        label: Text(languageService.translate('calculate_crop_yield')),
                        style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                if (resultKg != null) ...[
                  Text(languageService.translate('estimates'), style: textTheme.titleLarge),
                  SizedBox(height: 12),
                  buildInfoCard(
                    icon: Icons.agriculture,
                    label: languageService.translate('estimated_yield'),
                    value: "${resultKg!.toStringAsFixed(2)} kg\n"
                        "${(resultKg! / 100).toStringAsFixed(2)} quintals\n"
                        "${(resultKg! / 1000).toStringAsFixed(2)} tons",
                  ),
                  buildInfoCard(
                    icon: Icons.grass,
                    label: languageService.translate('crop_yield_per_unit'),
                    value: "${(resultKg! / double.parse(_areaController.text)).toStringAsFixed(2)} kg/${languageService.translate(selectedUnit)}",
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.orange),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _areaController.dispose();
    super.dispose();
  }
}
