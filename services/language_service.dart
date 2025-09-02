import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService extends ChangeNotifier {
  static const String _languageKey = 'selected_language';
  static const String _defaultLanguage = 'en';
  
  Locale _currentLocale = const Locale('en');
  Map<String, dynamic> _translations = {};
  bool _isLoading = false;
  bool _isInitialized = false;

  Locale get currentLocale => _currentLocale;
  Map<String, dynamic> get translations => _translations;
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;

  LanguageService() {
    _initializeLanguage();
  }

  Future<void> _initializeLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString(_languageKey) ?? _defaultLanguage;
      print('Loading saved language: $savedLanguage');
      await changeLanguage(savedLanguage);
      _isInitialized = true;
    } catch (e) {
      print('Error loading saved language: $e');
      await changeLanguage(_defaultLanguage);
      _isInitialized = true;
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    print('Attempting to change language to: $languageCode');
    if (_currentLocale.languageCode == languageCode && _isInitialized) {
      print('Language already set to: $languageCode');
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // Load translations from JSON file
      print('Loading translations for: $languageCode');
      
      // Check if the file exists first
      try {
        final jsonString = await rootBundle.loadString('assets/lang/$languageCode.json');
        print('Raw JSON string length: ${jsonString.length}');
        print('Raw JSON string preview: ${jsonString.substring(0, 100)}...');
        
        _translations = json.decode(jsonString);
        print('Loaded ${_translations.length} translations');
        
        // Validate that we have the essential translations
        final essentialKeys = ['crop_production', 'crop_production_calculator', 'enter_land_area'];
        for (var key in essentialKeys) {
          if (!_translations.containsKey(key)) {
            print('WARNING: Missing essential translation key: $key');
          }
        }
        
        // Show first few translations for debugging
        final entries = _translations.entries.take(3).toList();
        print('Sample translations:');
        for (var entry in entries) {
          print('  ${entry.key}: ${entry.value}');
        }
        
        _currentLocale = Locale(languageCode);
        print('Locale changed to: ${_currentLocale.languageCode}');
        
        // Save selected language
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_languageKey, languageCode);
        print('Language saved to preferences: $languageCode');
        
        // Test specific crop production translations
        print('Testing crop production translations:');
        print('  crop_production: ${_translations['crop_production']}');
        print('  crop_production_calculator: ${_translations['crop_production_calculator']}');
        print('  enter_land_area: ${_translations['enter_land_area']}');
        print('  select_unit: ${_translations['select_unit']}');
        print('  select_crop: ${_translations['select_crop']}');
        print('  calculate_crop_yield: ${_translations['calculate_crop_yield']}');
        
      } catch (fileError) {
        print('Error loading language file for $languageCode: $fileError');
        throw fileError;
      }
      
    } catch (e) {
      print('Error loading language $languageCode: $e');
      // Fallback to English
      try {
        print('Attempting fallback to English...');
        final jsonString = await rootBundle.loadString('assets/lang/en.json');
        _translations = json.decode(jsonString);
        _currentLocale = const Locale('en');
        print('Fallback to English loaded ${_translations.length} translations');
      } catch (fallbackError) {
        print('Error loading fallback English: $fallbackError');
        _translations = {};
        _currentLocale = const Locale('en');
      }
    }

    _isLoading = false;
    print('Notifying listeners of language change');
    notifyListeners();
  }

  String translate(String key) {
    if (!_isInitialized || _translations.isEmpty) {
      print('Translations not loaded yet for key: $key');
      return key;
    }
    
    final translation = _translations[key];
    if (translation == null) {
      print('Translation not found for key: $key');
      return key;
    }
    
    print('Translating "$key" to "$translation"');
    return translation.toString();
  }

  // Test method to verify translations
  Future<void> testTranslations() async {
    print('=== Testing Translations ===');
    print('Current locale: ${_currentLocale.languageCode}');
    print('Translations loaded: ${_translations.length}');
    print('Sample translations:');
    _translations.forEach((key, value) {
      print('  $key: $value');
    });
    print('=== End Test ===');
  }

  // Simple test method to check if service is working
  String testTranslate(String key) {
    print('Testing translation for key: $key');
    print('Current locale: ${_currentLocale.languageCode}');
    print('Is initialized: $_isInitialized');
    print('Translations count: ${_translations.length}');
    
    if (!_isInitialized) {
      print('Service not initialized yet');
      return 'NOT_INITIALIZED';
    }
    
    if (_translations.isEmpty) {
      print('No translations loaded');
      return 'NO_TRANSLATIONS';
    }
    
    final translation = _translations[key];
    if (translation == null) {
      print('Translation not found for key: $key');
      return 'NOT_FOUND';
    }
    
    print('Translation found: $translation');
    return translation.toString();
  }

  bool get isEnglish => _currentLocale.languageCode == 'en';
  bool get isHindi => _currentLocale.languageCode == 'hi';
}


