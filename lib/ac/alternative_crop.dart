import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class AlternativeCropsScreen extends StatelessWidget {
  const AlternativeCropsScreen({super.key});

  final List<Map<String, String>> alternativeCrops = const [
    {
      'name': 'Cowpea (Lobia)',
      'benefit': 'Improves soil nitrogen through nitrogen fixation and provides good yield as food crop.',
      'details': 'Cowpea is a legume that fixes atmospheric nitrogen into the soil, enhancing fertility. It grows well in warm climates and is drought resistant. It can be intercropped or rotated with cereals.'
    },
    {
      'name': 'Green Gram (Moong)',
      'benefit':
          'Fixes nitrogen and improves soil organic matter while producing nutritious pulses.',
      'details':
          'Green Gram is a short-duration legume crop that enriches soil fertility and breaks disease cycles. It helps reduce the need for synthetic fertilizers.'
    },
    {
      'name': 'Sesbania (Dhaincha)',
      'benefit':
          'Fast-growing green manure crop that enriches soil organic matter and nitrogen.',
      'details':
          'Sesbania is used as a green manure; it is plowed back into the soil before flowering to improve fertility and structure.'
    },
    {
      'name': 'Sunn Hemp',
      'benefit':
          'Improves soil nitrogen and organic carbon, suppresses weeds and pests.',
      'details':
          'Sunn Hemp is a leguminous cover crop that can be grown during fallow periods. It decomposes quickly adding organic matter and nutrients.'
    },
    {
      'name': 'Groundnut (Peanut)',
      'benefit':
          'Fixes nitrogen and provides oilseed crop, improving farm income and soil health.',
      'details':
          'Groundnut adds nitrogen to soil and breaks pest and disease cycles when rotated with cereals.'
    },
    {
      'name': 'Sesame',
      'benefit':
          'Improves soil aeration and can be grown in rotation to enhance nutrient cycling.',
      'details':
          'Sesame is a hardy oilseed crop that does well on light soils and helps diversify cropping systems.'
    },
    {
      'name': 'Mustard',
      'benefit':
          'Acts as a biofumigant to control soil-borne pests and diseases, improving soil health.',
      'details':
          'Mustard releases natural compounds that suppress nematodes and pathogens; can be used as a rotational crop.'
    },
    {
      'name': 'Sunflower',
      'benefit':
          'Deep rooting system helps improve soil structure and provides valuable oilseeds.',
      'details':
          'Sunflower roots loosen compacted soil layers and contribute organic residues.'
    },
    {
      'name': 'Fodder Crops (Napier Grass)',
      'benefit':
          'Adds organic matter and prevents soil erosion; supports livestock farming.',
      'details':
          'Napier Grass can be grown in bunds and as intercrop to reduce soil erosion and increase biomass.'
    },
    {
      'name': 'Chickpea (Gram)',
      'benefit': 'Enhances soil nitrogen and breaks cereal disease cycles.',
      'details':
          'Chickpea is a major pulse crop with nitrogen-fixing ability and drought tolerance.'
    },
  ];

  void showCropDetails(BuildContext context, Map<String, String> crop) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Consumer<LanguageService>(
          builder: (context, languageService, _) {
            String nameKey = _altCropNameToKey(crop['name'] ?? '');
            return Text(
              languageService.translate(nameKey),
              style: const TextStyle(color: Colors.orangeAccent),
            );
          },
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<LanguageService>(
                builder: (context, languageService, _) => Text('🌿 ' + languageService.translate('benefits') + ':\n' + languageService.translate(_altBenefitKey(crop['name'] ?? ''))),
              ),
              const SizedBox(height: 12),
              Consumer<LanguageService>(
                builder: (context, languageService, _) => Text('📋 ' + languageService.translate('details') + ':\n' + languageService.translate(_altDetailKey(crop['name'] ?? ''))),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Consumer<LanguageService>(
              builder: (context, languageService, _) => Text(
                languageService.translate('close'),
                style: const TextStyle(color: Colors.orangeAccent),
              ),
            ),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }

  String _altBenefitKey(String name) {
    switch (name) {
      case 'Cowpea (Lobia)':
        return 'alt_cowpea_benefit';
      case 'Green Gram (Moong)':
        return 'alt_green_gram_benefit';
      case 'Sesbania (Dhaincha)':
        return 'alt_sesbania_benefit';
      case 'Sunn Hemp':
        return 'alt_sunn_hemp_benefit';
      case 'Groundnut (Peanut)':
        return 'alt_groundnut_benefit';
      case 'Sesame':
        return 'alt_sesame_benefit';
      case 'Mustard':
        return 'alt_mustard_benefit';
      case 'Sunflower':
        return 'alt_sunflower_benefit';
      case 'Fodder Crops (Napier Grass)':
        return 'alt_napier_benefit';
      case 'Chickpea (Gram)':
        return 'alt_chickpea_benefit';
      default:
        return '';
    }
  }

  String _altDetailKey(String name) {
    switch (name) {
      case 'Cowpea (Lobia)':
        return 'alt_cowpea_details';
      case 'Green Gram (Moong)':
        return 'alt_green_gram_details';
      case 'Sesbania (Dhaincha)':
        return 'alt_sesbania_details';
      case 'Sunn Hemp':
        return 'alt_sunn_hemp_details';
      case 'Groundnut (Peanut)':
        return 'alt_groundnut_details';
      case 'Sesame':
        return 'alt_sesame_details';
      case 'Mustard':
        return 'alt_mustard_details';
      case 'Sunflower':
        return 'alt_sunflower_details';
      case 'Fodder Crops (Napier Grass)':
        return 'alt_napier_details';
      case 'Chickpea (Gram)':
        return 'alt_chickpea_details';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(languageService.translate('alternative_crops_for_soil_fertility')),
            backgroundColor: Colors.orangeAccent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: alternativeCrops.length,
              itemBuilder: (context, index) {
                final crop = alternativeCrops[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.grass, color: Colors.orangeAccent),
                    title: Text(languageService.translate(_altCropNameToKey(crop['name'] ?? ''))),
                    subtitle: Text(
                      languageService.translate(_altBenefitKey(crop['name'] ?? '')),
                    ),
                    trailing:
                        const Icon(Icons.info_outline, color: Colors.orangeAccent),
                    onTap: () => showCropDetails(context, crop),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  String _altCropNameToKey(String name) {
    switch (name) {
      case 'Cowpea (Lobia)':
        return 'cowpea';
      case 'Green Gram (Moong)':
        return 'green_gram';
      case 'Sesbania (Dhaincha)':
        return 'sesbania';
      case 'Sunn Hemp':
        return 'sunn_hemp';
      case 'Groundnut (Peanut)':
        return 'groundnut';
      case 'Sesame':
        return 'sesame';
      case 'Mustard':
        return 'mustard';
      case 'Sunflower':
        return 'sunflower';
      case 'Fodder Crops (Napier Grass)':
        return 'napier_grass';
      case 'Chickpea (Gram)':
        return 'chickpea';
      default:
        return name;
    }
  }
}
