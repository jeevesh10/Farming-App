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
import 'services/font_service.dart';
import 'services/sound_service.dart';
import 'widgets/network_aware_widget.dart';
import 'widgets/language_selector.dart';
import 'widgets/clickable_widget.dart';
import 'widgets/clickable_tab_bar.dart';

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
    return Consumer3<LanguageService, FontService, SoundService>(
      builder: (context, languageService, fontService, soundService, child) {
        return NetworkAwareWidget(
          child: Scaffold(
              backgroundColor: _isDarkMode ? Colors.black : Colors.white,
                appBar: AppBar(
                title: Text(languageService.translate('home'), 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontService.titleFontSize,
                      color: _isDarkMode ? Colors.white : Colors.black,
                    )),
                backgroundColor: _isDarkMode ? Colors.black : Colors.orangeAccent,
                iconTheme: IconThemeData(color: _isDarkMode ? Colors.white : Colors.black),
                actions: [
                  ClickableWidget(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => LanguageSelector(isDarkMode: _isDarkMode),
                      );
                    },
                    child: IconButton(
                      icon: const Icon(Icons.language),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => LanguageSelector(isDarkMode: _isDarkMode),
                        );
                      },
                    ),
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
                    child: ClickableTabBar(
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
                        Tab(child: Text(languageService.translate('farming_methods'), style: TextStyle(fontSize: fontService.fontSize - 2))),
                        Tab(child: Text(languageService.translate('soil_management'), style: TextStyle(fontSize: fontService.fontSize - 2))),
                        Tab(child: Text(languageService.translate('weather_prediction'), style: TextStyle(fontSize: fontService.fontSize - 2))),
                        Tab(child: Text(languageService.translate('crop_production'), style: TextStyle(fontSize: fontService.fontSize - 2))),
                        Tab(child: Text(languageService.translate('government_prices'), style: TextStyle(fontSize: fontService.fontSize - 2))),
                        Tab(child: Text(languageService.translate('best_crop_season'), style: TextStyle(fontSize: fontService.fontSize - 2))),
                        Tab(child: Text(languageService.translate('alternative_crops'), style: TextStyle(fontSize: fontService.fontSize - 2))),
                      ],
                    ),
                  ),
                ),
              ),
              drawer: Drawer(
                backgroundColor: _isDarkMode ? Colors.grey[850] : Colors.white,
                child: Column(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: _isDarkMode ? Colors.black : Colors.orangeAccent,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClickableWidget(
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
                                fontSize: fontService.titleFontSize,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text('hamster@theme.com',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: fontService.fontSize,
                              )),
                        ],
                      ),
                    ),
                    ClickableListTile(
                      leading: Icon(Icons.settings,
                          color: _isDarkMode ? Colors.white : Colors.orangeAccent),
                      title: Text(
                        languageService.translate('settings'),
                        style: TextStyle(
                          fontSize: fontService.fontSize,
                          color: _isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
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
                    Divider(color: _isDarkMode ? Colors.white30 : Colors.grey),
                    ClickableListTile(
                      leading: Icon(Icons.dark_mode,
                          color: _isDarkMode ? Colors.yellow : Colors.grey),
                      title: Text(
                        languageService.translate('dark_mode'),
                        style: TextStyle(
                          fontSize: fontService.fontSize,
                          color: _isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
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
                    ClickableListTile(
                      leading: Icon(Icons.logout, color: Colors.redAccent),
                      title: Text(
                        languageService.translate('logout'),
                        style: TextStyle(
                          fontSize: fontService.fontSize,
                          color: _isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
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
                      ManagementPage(isDarkMode: _isDarkMode, showAppBar: false),
                      Container(
                        color: _isDarkMode ? Colors.black87 : Colors.white,
                        child: SoilManagementPage(),
                      ),
                      Container(
                        color: _isDarkMode ? Colors.black87 : Colors.white,
                        child: WeatherPredictionPage(),
                      ),
                      Container(
                        color: _isDarkMode ? Colors.black87 : Colors.white,
                        child: CropProductionPage(),
                      ),
                      Container(
                        color: _isDarkMode ? Colors.black87 : Colors.white,
                        child: GovtCropPricesScreen(),
                      ),
                      Container(
                        color: _isDarkMode ? Colors.black87 : Colors.white,
                        child: BestCropSeasonScreen(),
                      ),
                      Container(
                        color: _isDarkMode ? Colors.black87 : Colors.white,
                        child: AlternativeCropsScreen(),
                      ),
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
