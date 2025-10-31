import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language_service.dart';

enum FontSizeOption {
  small,
  medium,
  large,
}

class FontService extends ChangeNotifier {
  static final FontService _instance = FontService._internal();
  factory FontService() => _instance;
  FontService._internal();

  FontSizeOption _currentFontSize = FontSizeOption.medium;
  static const String _fontSizeKey = 'font_size';

  FontSizeOption get currentFontSize => _currentFontSize;

  double get fontSize {
    switch (_currentFontSize) {
      case FontSizeOption.small:
        return 14.0;
      case FontSizeOption.medium:
        return 16.0;
      case FontSizeOption.large:
        return 20.0;
    }
  }

  double get titleFontSize {
    switch (_currentFontSize) {
      case FontSizeOption.small:
        return 16.0;
      case FontSizeOption.medium:
        return 18.0;
      case FontSizeOption.large:
        return 22.0;
    }
  }

  double get headingFontSize {
    switch (_currentFontSize) {
      case FontSizeOption.small:
        return 18.0;
      case FontSizeOption.medium:
        return 20.0;
      case FontSizeOption.large:
        return 24.0;
    }
  }

  String get fontSizeLabel {
    // This method is deprecated - use getFontSizeLabel(LanguageService) instead
    switch (_currentFontSize) {
      case FontSizeOption.small:
        return 'Small';
      case FontSizeOption.medium:
        return 'Medium';
      case FontSizeOption.large:
        return 'Large';
    }
  }

  String getFontSizeLabel(LanguageService languageService) {
    switch (_currentFontSize) {
      case FontSizeOption.small:
        return languageService.translate('small');
      case FontSizeOption.medium:
        return languageService.translate('medium');
      case FontSizeOption.large:
        return languageService.translate('large');
    }
  }

  // Initialize font service and load preferences
  Future<void> initialize() async {
    await _loadFontPreference();
  }

  // Load font preference from shared preferences
  Future<void> _loadFontPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final fontSizeIndex = prefs.getInt(_fontSizeKey) ?? FontSizeOption.medium.index;
      _currentFontSize = FontSizeOption.values[fontSizeIndex];
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading font preference: $e');
      }
    }
  }

  // Save font preference to shared preferences
  Future<void> _saveFontPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_fontSizeKey, _currentFontSize.index);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving font preference: $e');
      }
    }
  }

  // Set font size
  Future<void> setFontSize(FontSizeOption fontSize) async {
    if (_currentFontSize != fontSize) {
      _currentFontSize = fontSize;
      await _saveFontPreference();
      notifyListeners();
    }
  }
}
