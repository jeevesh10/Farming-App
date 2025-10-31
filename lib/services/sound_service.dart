import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class SoundService extends ChangeNotifier {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;
  SoundService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _soundEnabled = true;
  static const String _soundEnabledKey = 'sound_enabled';

  bool get soundEnabled => _soundEnabled;

  // Initialize sound service and load preferences
  Future<void> initialize() async {
    await _loadSoundPreference();
  }

  // Load sound preference from shared preferences
  Future<void> _loadSoundPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _soundEnabled = prefs.getBool(_soundEnabledKey) ?? true;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading sound preference: $e');
      }
    }
  }

  // Save sound preference to shared preferences
  Future<void> _saveSoundPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_soundEnabledKey, _soundEnabled);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving sound preference: $e');
      }
    }
  }

  // Toggle sound on/off
  Future<void> toggleSound() async {
    _soundEnabled = !_soundEnabled;
    await _saveSoundPreference();
    notifyListeners();
  }

  // Set sound enabled/disabled
  Future<void> setSoundEnabled(bool enabled) async {
    if (_soundEnabled != enabled) {
      _soundEnabled = enabled;
      await _saveSoundPreference();
      notifyListeners();
    }
  }

  // Play click sound
  Future<void> playClickSound() async {
    if (!_soundEnabled) return;

    try {
      // Stop any currently playing sound
      await _audioPlayer.stop();
      // Play the click sound
      await _audioPlayer.play(AssetSource('sounds/button-click.mp3'));
    } catch (e) {
      if (kDebugMode) {
        print('Error playing click sound: $e');
      }
    }
  }

  // Dispose resources
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
