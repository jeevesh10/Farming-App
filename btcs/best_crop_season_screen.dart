import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class BestCropSeasonScreen extends StatelessWidget {
  const BestCropSeasonScreen({super.key});

  String _cropNameToKey(String name) {
    switch (name) {
      case 'Paddy':
        return 'paddy';
      case 'Maize':
        return 'maize';
      case 'Cotton':
        return 'cotton';
      case 'Soybean':
        return 'soybean';
      case 'Groundnut':
        return 'groundnut';
      case 'Sugarcane':
        return 'sugarcane';
      case 'Black Gram':
        return 'black_gram';
      case 'Wheat':
        return 'wheat';
      case 'Barley':
        return 'barley';
      case 'Mustard':
        return 'mustard';
      case 'Gram (Chickpea)':
        return 'gram_chickpea';
      case 'Peas':
        return 'peas';
      case 'Linseed':
        return 'linseed';
      case 'Watermelon':
        return 'watermelon';
      case 'Cucumber':
        return 'cucumber';
      case 'Pumpkin':
        return 'pumpkin';
      case 'Bitter Gourd':
        return 'bitter_gourd';
      case 'Moong (Green Gram)':
        return 'moong_green_gram';
      case 'Sunflower':
        return 'sunflower';
      case 'Sesame':
        return 'sesame';
      default:
        return name;
    }
  }

  String getCurrentSeason() {
    final month = DateTime.now().month;
    if (month >= 6 && month <= 9) return 'Kharif';
    if (month >= 10 || month <= 2) return 'Rabi';
    return 'Zaid';
  }

  List<Map<String, String>> getCropDetails(String season) {
    switch (season) {
      case 'Kharif':
        return [
          {
            'name': 'paddy',
            'season': 'crop_paddy_season',
            'how': 'crop_paddy_how',
            'precautions': 'crop_paddy_precautions'
          },
          {
            'name': 'maize',
            'season': 'crop_maize_season',
            'how': 'crop_maize_how',
            'precautions': 'crop_maize_precautions'
          },
          {
            'name': 'cotton',
            'season': 'crop_cotton_season',
            'how': 'crop_cotton_how',
            'precautions': 'crop_cotton_precautions'
          },
          {
            'name': 'soybean',
            'season': 'crop_soybean_season',
            'how': 'crop_soybean_how',
            'precautions': 'crop_soybean_precautions'
          },
          {
            'name': 'groundnut',
            'season': 'crop_groundnut_season',
            'how': 'crop_groundnut_how',
            'precautions': 'crop_groundnut_precautions'
          },
          {
            'name': 'sugarcane',
            'season': 'crop_sugarcane_season',
            'how': 'crop_sugarcane_how',
            'precautions': 'crop_sugarcane_precautions'
          },
          {
            'name': 'black_gram',
            'season': 'crop_black_gram_season',
            'how': 'crop_black_gram_how',
            'precautions': 'crop_black_gram_precautions'
          },
        ];
      case 'Rabi':
        return [
          {
            'name': 'wheat',
            'season': 'crop_wheat_season',
            'how': 'crop_wheat_how',
            'precautions': 'crop_wheat_precautions'
          },
          {
            'name': 'barley',
            'season': 'crop_barley_season',
            'how': 'crop_barley_how',
            'precautions': 'crop_barley_precautions'
          },
          {
            'name': 'mustard',
            'season': 'crop_mustard_season',
            'how': 'crop_mustard_how',
            'precautions': 'crop_mustard_precautions'
          },
          {
            'name': 'gram_chickpea',
            'season': 'crop_gram_chickpea_season',
            'how': 'crop_gram_chickpea_how',
            'precautions': 'crop_gram_chickpea_precautions'
          },
          {
            'name': 'peas',
            'season': 'crop_peas_season',
            'how': 'crop_peas_how',
            'precautions': 'crop_peas_precautions'
          },
          {
            'name': 'linseed',
            'season': 'crop_linseed_season',
            'how': 'crop_linseed_how',
            'precautions': 'crop_linseed_precautions'
          },
          {
            'name': 'mustard',
            'season': 'crop_mustard_season',
            'how': 'crop_mustard_how',
            'precautions': 'crop_mustard_precautions'
          },
        ];
      case 'Zaid':
        return [
          {
            'name': 'watermelon',
            'season': 'crop_watermelon_season',
            'how': 'crop_watermelon_how',
            'precautions': 'crop_watermelon_precautions'
          },
          {
            'name': 'cucumber',
            'season': 'crop_cucumber_season',
            'how': 'crop_cucumber_how',
            'precautions': 'crop_cucumber_precautions'
          },
          {
            'name': 'pumpkin',
            'season': 'crop_pumpkin_season',
            'how': 'crop_pumpkin_how',
            'precautions': 'crop_pumpkin_precautions'
          },
          {
            'name': 'bitter_gourd',
            'season': 'crop_bitter_gourd_season',
            'how': 'crop_bitter_gourd_how',
            'precautions': 'crop_bitter_gourd_precautions'
          },
          {
            'name': 'moong_green_gram',
            'season': 'crop_moong_green_gram_season',
            'how': 'crop_moong_green_gram_how',
            'precautions': 'crop_moong_green_gram_precautions'
          },
          {
            'name': 'sunflower',
            'season': 'crop_sunflower_season',
            'how': 'crop_sunflower_how',
            'precautions': 'crop_sunflower_precautions'
          },
          {
            'name': 'sesame',
            'season': 'crop_sesame_season',
            'how': 'crop_sesame_how',
            'precautions': 'crop_sesame_precautions'
          },
        ];
      default:
        return [];
    }
  }

  void showCropDetails(BuildContext context, Map<String, String> crop) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Consumer<LanguageService>(
          builder: (context, languageService, _) => Text(
            languageService.translate(_cropNameToKey(crop['name'] ?? '')),
            style: const TextStyle(color: Colors.orangeAccent),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<LanguageService>(
                builder: (context, languageService, _) => Text('🌱 ' + languageService.translate('season_label') + ': ' + languageService.translate(crop['season'] ?? '')),
              ),
              const SizedBox(height: 10),
              Consumer<LanguageService>(
                builder: (context, languageService, _) => Text('✅ ' + languageService.translate('how_to_grow') + ':\n' + languageService.translate(crop['how'] ?? '')),
              ),
              const SizedBox(height: 10),
              Consumer<LanguageService>(
                builder: (context, languageService, _) => Text('⚠️ ' + languageService.translate('precautions_label') + ':\n' + languageService.translate(crop['precautions'] ?? '')),
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

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        final season = getCurrentSeason();
        final cropList = getCropDetails(season);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orangeAccent,
            title: Text(languageService.translate('best_crops_for_season')),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🌾 ${languageService.translate('current_season')}: ' +
                      (season == 'Kharif'
                          ? languageService.translate('season_kharif')
                          : season == 'Rabi'
                              ? languageService.translate('season_rabi')
                              : languageService.translate('season_zaid')),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 20),
                Text(
                  languageService.translate('recommended_crops'),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                ...cropList.map((crop) => Card(
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                       child: ListTile(
                        leading: const Icon(Icons.eco, color: Colors.orangeAccent),
                         title: Text(languageService.translate(_cropNameToKey(crop['name'] ?? ''))),
                        subtitle: Text(languageService.translate('tap_to_view_details')),
                        trailing: const Icon(Icons.info_outline),
                        onTap: () => showCropDetails(context, crop),
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
