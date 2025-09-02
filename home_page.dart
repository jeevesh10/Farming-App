import 'package:annagrah/CP/crop_production_page.dart';
import 'package:annagrah/SM/SoilManagementPage.dart';
import 'package:annagrah/ac/alternative_crop.dart';
import 'package:annagrah/btcs/best_crop_season_screen.dart';
import 'package:annagrah/gcp/govt_crop_prices_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'S/profile_page.dart';
import 'S/settings_page.dart';
import 'FM/management_page.dart';
import 'package:annagrah/WeatherPredictionPage.dart';
import 'services/language_service.dart';
import 'services/connectivity_service.dart';
import 'widgets/network_aware_widget.dart';
import 'widgets/language_selector.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool _isDarkMode = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return NetworkAwareWidget(
          child: Scaffold(
              appBar: AppBar(
                title: Text(languageService.translate('home'), 
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: _isDarkMode ? Colors.black : Colors.orangeAccent,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.language),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const LanguageSelector(),
                      );
                    },
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _isDarkMode ? Colors.grey[800] : Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: _isDarkMode ? Colors.orangeAccent : Colors.white,
                      unselectedLabelColor:
                          _isDarkMode ? Colors.white70 : Colors.black54,
                      indicator: BoxDecoration(
                        color: _isDarkMode ? Colors.black54 : Colors.white24,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      tabs: [
                        Tab(text: languageService.translate('farming_methods')),
                        Tab(text: languageService.translate('soil_management')),
                        Tab(text: languageService.translate('weather_prediction')),
                        Tab(text: languageService.translate('crop_production')),
                        Tab(text: languageService.translate('government_prices')),
                        Tab(text: languageService.translate('best_crop_season')),
                        Tab(text: languageService.translate('alternative_crops')),
                      ],
                    ),
                  ),
                ),
              ),
              drawer: Drawer(
                child: Column(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: _isDarkMode ? Colors.black : Colors.orangeAccent,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()),
                              );
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage("assets/image/logo.png"),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            languageService.translate('welcome'),
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text('hamster@theme.com',
                              style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings,
                          color: _isDarkMode ? Colors.white : Colors.orangeAccent),
                      title: Text(languageService.translate('settings')),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage(
                                  isDarkMode: _isDarkMode,
                                  onThemeChanged: (value) {
                                    setState(() {
                                      _isDarkMode = value;
                                    });
                                  })),
                        );
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.dark_mode,
                          color: _isDarkMode ? Colors.yellow : Colors.grey),
                      title: Text(languageService.translate('dark_mode')),
                      trailing: Switch(
                        value: _isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            _isDarkMode = value;
                          });
                        },
                        activeColor: Colors.orangeAccent,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.redAccent),
                      title: Text(languageService.translate('logout')),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              body: Stack(
                children: [
                  Center(
                    child: Opacity(
                      opacity: 0.2,
                      child: Image.asset("assets/image/logo.png",
                          width: 200, height: 200),
                    ),
                  ),
                  TabBarView(
                    controller: _tabController,
                    children: [
                      // Link to the Farming Management page
                      ManagementPage(),
                      SoilManagementPage(),
                      WeatherPredictionPage(),
                      CropProductionPage(),
                      GovtCropPricesScreen(),
                      BestCropSeasonScreen(),
                      AlternativeCropsScreen(),
                    ],
                  ),
                ],
              ),
          ),
        );
      },
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: _isDarkMode ? Colors.white : Colors.black);
  }
}
