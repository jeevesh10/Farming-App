import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/language_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherPredictionPage extends StatefulWidget {
  const WeatherPredictionPage({super.key});

  @override
  _WeatherPredictionPageState createState() => _WeatherPredictionPageState();
}

class _WeatherPredictionPageState extends State<WeatherPredictionPage> {
  String apiKey = 'd5e332da19174eb6bd5113512252202';
  TextEditingController cityController = TextEditingController();
  Map<String, dynamic>? weatherData;

  Future<void> fetchWeatherData(String city) async {
    try {
      if (city.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid city name")),
        );
        return;
      }

      final url = Uri.parse(
          'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=2&aqi=no&alerts=no');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
        });
      } else {
        setState(() {
          weatherData = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("City not found: $city")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to fetch weather data")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return Scaffold(
          backgroundColor: Colors.orange.shade100,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Search Box
                    TextField(
                      controller: cityController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: languageService.translate('enter_city_name'),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        fetchWeatherData(cityController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Colors.orange.shade400,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                      ),
                      child:
                          Text(languageService.translate('get_weather'), style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(height: 20),

                    // Weather Info Card
                    if (weatherData != null) buildWeatherCard(languageService),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildWeatherCard(LanguageService languageService) {
    var currentWeather = weatherData!['current'];
    var location = weatherData!['location'];
    var forecastDay =
        weatherData!['forecast']['forecastday'][1]; // Next day's forecast
    var astro = forecastDay['astro']; // Astronomy data

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Location
            Text(
              '${location['name']}, ${location['country']}',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Weather Icon
            Image.network(
              'https:${currentWeather['condition']['icon']}',
              width: 100,
              height: 100,
            ),

            // Temperature
            Text(
              '${currentWeather['temp_c']}°C',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),

            // Condition
            Text(
              '${currentWeather['condition']['text']}',
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey),
            ),
            const SizedBox(height: 10),

            // Weather Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildWeatherDetail(Icons.water_drop, languageService.translate('humidity'),
                    '${currentWeather['humidity']}%', languageService),
                buildWeatherDetail(
                    Icons.air, languageService.translate('wind'), '${currentWeather['wind_kph']} kph', languageService),
                buildWeatherDetail(Icons.thermostat, languageService.translate('feels_like'),
                    '${currentWeather['feelslike_c']}°C', languageService),
              ],
            ),
            const SizedBox(height: 10),
            buildWeatherDetail(Icons.speed, languageService.translate('pressure'),
                '${currentWeather['pressure_mb']} hPa', languageService),

            const SizedBox(height: 20),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),

            // Astronomy Details
            Text(
              languageService.translate('astronomy_data'),
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildWeatherDetail(Icons.wb_sunny, languageService.translate('sunrise'), astro['sunrise'], languageService),
                buildWeatherDetail(
                    Icons.nightlight_round, languageService.translate('sunset'), astro['sunset'], languageService),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildWeatherDetail(
                    Icons.brightness_3, languageService.translate('moonrise'), astro['moonrise'], languageService),
                buildWeatherDetail(
                    Icons.nights_stay, languageService.translate('moonset'), astro['moonset'], languageService),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),

            // Next Day's Weather
            Text(
              languageService.translate('tomorrows_weather'),
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            const SizedBox(height: 10),
            Image.network(
              'https:${forecastDay['day']['condition']['icon']}',
              width: 80,
              height: 80,
            ),
            Text(
              '${forecastDay['day']['avgtemp_c']}°C',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(
              '${forecastDay['day']['condition']['text']}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWeatherDetail(IconData icon, String label, String value, LanguageService languageService) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 30),
        const SizedBox(height: 5),
        Text(label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87)),
        Text(value,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ],
    );
  }
}
