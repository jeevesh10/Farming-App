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
    _isLoading = true;
    notifyListeners();

    try {
      final jsonString = await rootBundle.loadString('assets/lang/$languageCode.json');
      _translations = json.decode(jsonString);
      _currentLocale = Locale(languageCode);
      
      // Save to preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
      
    } catch (e) {
      print('Error loading language $languageCode: $e');
      // Fallback to English
      final jsonString = await rootBundle.loadString('assets/lang/en.json');
      _translations = json.decode(jsonString);
      _currentLocale = const Locale('en');
    }

    _isLoading = false;
    notifyListeners();
  }

  String translate(String key) {
    if (!_isInitialized || _translations.isEmpty) {
      // Only log when translations aren't loaded
      return key;
    }
    
    final translation = _translations[key];
    if (translation == null) {
      // Only log missing translations
      print('Translation not found for key: $key');
      return key;
    }
    
    // Return translation without verbose logging
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

  // Debug method to force language change without full app restart
  Future<void> debugForceLanguageChange(String languageCode) async {
    print('DEBUG: Force changing language to $languageCode');
    _isLoading = true;
    notifyListeners();

    try {
      final jsonString = await rootBundle.loadString('assets/lang/$languageCode.json');
      print('DEBUG: Successfully loaded $languageCode.json');
      _translations = json.decode(jsonString);
      print('DEBUG: Parsed JSON with ${_translations.length} translations');
      _currentLocale = Locale(languageCode);
      
      // Save to preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
      print('DEBUG: Saved language preference: $languageCode');
      
    } catch (e) {
      print('DEBUG: Error loading language $languageCode: $e');
      // Fallback to English
      final jsonString = await rootBundle.loadString('assets/lang/en.json');
      _translations = json.decode(jsonString);
      _currentLocale = const Locale('en');
    }

    _isLoading = false;
    print('DEBUG: Language change complete. New locale: ${_currentLocale.languageCode}');
    notifyListeners();
  }
}


