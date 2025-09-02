import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';
import 'package:url_launcher/url_launcher.dart';

class GovtCropPricesScreen extends StatefulWidget {
  const GovtCropPricesScreen({super.key});

  @override
  State<GovtCropPricesScreen> createState() => _GovtCropPricesScreenState();
}

class _GovtCropPricesScreenState extends State<GovtCropPricesScreen> {
  final List<Map<String, String>> cropPrices = [
    {'crop': 'Wheat', 'price': '2125'},
    {'crop': 'Rice', 'price': '2040'},
    {'crop': 'Maize', 'price': '1850'},
    {'crop': 'Cotton', 'price': '6380'},
    {'crop': 'Barley', 'price': '1735'},
  ];

  final List<Map<String, String>> governmentSchemes = [
    {
      'key': 'pmkisan',
      'title': 'Pradhan Mantri Kisan Samman Nidhi',
      'description':
      'Direct income support of ₹6,000 per year to eligible farmer families.',
      'url': 'https://pmkisan.gov.in/',
      'category': 'Financial Support',
    },
    {
      'key': 'pmfby',
      'title': 'Pradhan Mantri Fasal Bima Yojana',
      'description':
      'Comprehensive crop insurance scheme for farmers.',
      'url': 'https://pmfby.gov.in/',
      'category': 'Insurance',
    },
    {
      'key': 'soil_health',
      'title': 'Soil Health Card Scheme',
      'description':
      'Provides soil health information to farmers for better crop management.',
      'url': 'https://soilhealth.dac.gov.in/',
      'category': 'Soil Management',
    },
    {
      'key': 'enam',
      'title': 'e-NAM (National Agriculture Market)',
      'description':
      'Online trading platform for agricultural commodities.',
      'url': 'https://enam.gov.in/',
      'category': 'Market Access',
    },
    {
      'key': 'kcc',
      'title': 'Kisan Credit Card',
      'description':
      'Easy credit access for farmers to meet agricultural needs.',
      'url': 'https://www.nabard.org/kisan-credit-card',
      'category': 'Financial Support',
    },
    {
      'key': 'pmksy',
      'title': 'PMKSY',
      'description':
      'Pradhan Mantri Krishi Sinchayee Yojana for irrigation facilities.',
      'url': 'https://pmksy.gov.in/',
      'category': 'Infrastructure',
    },
    {
      'key': 'pmfme',
      'title': 'PMFME',
      'description':
      'Pradhan Mantri Formalisation of Micro Food Processing Enterprises.',
      'url': 'https://pmfme.mofpi.gov.in/',
      'category': 'Processing',
    },
    {
      'key': 'pmksy_pdmc',
      'title': 'PMKSY-PDMC',
      'description':
      'Per Drop More Crop component for water use efficiency.',
      'url': 'https://pmksy.gov.in/',
      'category': 'Water Management',
    },
    {
      'key': 'nmsa',
      'title': 'National Mission for Sustainable Agriculture',
      'description':
      'Promotes sustainable farming practices and climate-resilient agriculture.',
      'url': 'https://nmsa.dac.gov.in/',
      'category': 'Sustainability',
    },
    {
      'key': 'rkvy',
      'title': 'Rashtriya Krishi Vikas Yojana',
      'description':
      'Comprehensive development of agriculture and allied sectors.',
      'url': 'https://rkvy.nic.in/',
      'category': 'Development',
    },
    {
      'key': 'pmksy_full',
      'title': 'Pradhan Mantri Krishi Sinchayee Yojana (PMKSY)',
      'description':
      'Har Khet Ko Paani - Water to every field.',
      'url': 'https://pmksy.gov.in/',
      'category': 'Irrigation',
    },
    {
      'key': 'nfsm',
      'title': 'National Food Security Mission',
      'description':
      'Increase production of rice, wheat, pulses, and coarse cereals.',
      'url': 'https://nfsm.gov.in/',
      'category': 'Food Security',
    },
  ];

  String _localizedSchemeTitle(Map<String, String> scheme, LanguageService ls) {
    if (!ls.isHindi) return scheme['title'] ?? '';
    const Map<String, String> hiTitles = {
      'pmkisan': 'प्रधान मंत्री किसान सम्मान निधि',
      'pmfby': 'प्रधान मंत्री फसल बीमा योजना',
      'soil_health': 'मृदा स्वास्थ्य कार्ड योजना',
      'enam': 'ई-नाम (राष्ट्रीय कृषि बाज़ार)',
      'kcc': 'किसान क्रेडिट कार्ड',
      'pmksy': 'पीएमकेएसवाई',
      'pmfme': 'पीएमएफएमई',
      'pmksy_pdmc': 'पीएमकेएसवाई - प्रति बूंद अधिक फसल',
      'nmsa': 'राष्ट्रीय सतत कृषि मिशन',
      'rkvy': 'राष्ट्रीय कृषि विकास योजना',
      'pmksy_full': 'प्रधान मंत्री कृषि सिंचाई योजना (पीएमकेएसवाई)',
      'nfsm': 'राष्ट्रीय खाद्य सुरक्षा मिशन',
    };
    return hiTitles[scheme['key']] ?? scheme['title'] ?? '';
  }

  String _localizedSchemeDesc(Map<String, String> scheme, LanguageService ls) {
    if (!ls.isHindi) return scheme['description'] ?? '';
    const Map<String, String> hiDescs = {
      'pmkisan': 'योग्य किसान परिवारों को प्रति वर्ष ₹6,000 की प्रत्यक्ष आय सहायता।',
      'pmfby': 'किसानों के लिए व्यापक फसल बीमा योजना।',
      'soil_health': 'बेहतर फसल प्रबंधन हेतु किसानों को मिट्टी स्वास्थ्य संबंधी जानकारी।',
      'enam': 'कृषि जिंसों के लिए ऑनलाइन ट्रेडिंग प्लेटफ़ॉर्म।',
      'kcc': 'कृषि आवश्यकताओं हेतु किसानों को आसान ऋण सुविधा।',
      'pmksy': 'सिंचाई सुविधाओं के लिए प्रधानमंत्री कृषि सिंचाई योजना।',
      'pmfme': 'सूक्ष्म खाद्य प्रसंस्करण उद्यमों के औपचारीकरण की योजना।',
      'pmksy_pdmc': 'प्रति बूंद अधिक फसल घटक से जल उपयोग दक्षता।',
      'nmsa': 'टिकाऊ खेती और जलवायु-सहिष्णु कृषि को बढ़ावा।',
      'rkvy': 'कृषि एवं सहयोगी क्षेत्रों का समग्र विकास।',
      'pmksy_full': 'हर खेत को पानी – प्रत्येक खेत तक सिंचाई सुविधा।',
      'nfsm': 'चावल, गेहूँ, दालें और मोटे अनाज का उत्पादन बढ़ाना।',
    };
    return hiDescs[scheme['key']] ?? scheme['description'] ?? '';
  }

  String? selectedCrop;
  double? enteredQuantity;
  double? totalAmount;
  final TextEditingController quantityController = TextEditingController();
  bool _isLaunchingURL = false;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredSchemes = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _checkUrlLauncherAvailability();
    _filteredSchemes = governmentSchemes;
  }

  @override
  void dispose() {
    quantityController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _checkUrlLauncherAvailability() async {
    try {
      final testUri = Uri.parse('https://www.google.com');
      final canLaunch = await canLaunchUrl(testUri);
      print('URL Launcher availability check: $canLaunch');
    } catch (e) {
      print('Error checking URL launcher availability: $e');
    }
  }

  void _calculateAmount() {
    if (selectedCrop != null && enteredQuantity != null) {
      final selected = cropPrices.firstWhere(
            (item) => item['crop'] == selectedCrop,
      );
      final pricePerQuintal = double.tryParse(selected['price'] ?? '0') ?? 0;
      setState(() {
        totalAmount = pricePerQuintal * enteredQuantity!;
      });
    }
  }

  void _launchURL(String url) async {
    setState(() {
      _isLaunchingURL = true;
    });
    try {
      print('Attempting to launch URL: $url');
      
      // Validate URL format
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https://$url';
      }
      
      // Additional URL validation
      if (!_isValidURL(url)) {
        _showErrorSnackBar('Invalid URL format: $url');
        return;
      }
      
      final uri = Uri.parse(url);
      print('Parsed URI: $uri');
      print('URI scheme: ${uri.scheme}');
      print('URI host: ${uri.host}');
      print('URI path: ${uri.path}');
      
      // Check if URL can be launched
      if (await canLaunchUrl(uri)) {
        print('URL can be launched, attempting to open...');
        final result = await launchUrl(
          uri, 
          mode: LaunchMode.externalApplication,
        );
        
        if (result) {
          print('URL launched successfully');
        } else {
          print('URL launch failed, trying fallback method...');
          await _launchURLFallback(uri);
        }
      } else {
        print('URL cannot be launched, trying fallback method...');
        await _launchURLFallback(uri);
      }
    } catch (e) {
      print('Error launching URL: $e');
      _showErrorSnackBar('Error opening link: $e');
    } finally {
      setState(() {
        _isLaunchingURL = false;
      });
    }
  }

  bool _isValidURL(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.hasAuthority;
    } catch (e) {
      print('URL validation error: $e');
      return false;
    }
  }

  Future<void> _launchURLFallback(Uri uri) async {
    try {
      print('Trying fallback URL launch method...');
      final result = await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
      );

      if (result) {
        print('Fallback URL launch successful');
      } else {
        print('Fallback URL launch failed');
        _showErrorSnackBar('Could not open the link. Please check your internet connection and try again.');
      }
    } catch (e) {
      print('Fallback URL launch error: $e');
      _showErrorSnackBar('Failed to open link: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _filterSchemes(String query) {
    setState(() {
      if (query.isEmpty && _selectedCategory == null) {
        _filteredSchemes = governmentSchemes;
      } else {
        _filteredSchemes = governmentSchemes.where((scheme) {
          final title = scheme['title']?.toLowerCase() ?? '';
          final description = scheme['description']?.toLowerCase() ?? '';
          final category = scheme['category']?.toLowerCase() ?? '';
          final searchQuery = query.toLowerCase();
          
          bool matchesSearch = query.isEmpty || 
              title.contains(searchQuery) || 
              description.contains(searchQuery);
          
          bool matchesCategory = _selectedCategory == null || 
              category == _selectedCategory?.toLowerCase();
          
          return matchesSearch && matchesCategory;
        }).toList();
      }
    });
  }

  void _filterByCategory(String? category) {
    setState(() {
      _selectedCategory = category;
      _filterSchemes(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        String cropNameToKey(String name) {
          switch (name) {
            case 'Wheat':
              return 'wheat';
            case 'Rice':
              return 'rice';
            case 'Maize':
              return 'maize';
            case 'Cotton':
              return 'cotton';
            case 'Barley':
              return 'barley';
            default:
              return name;
          }
        }
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.orangeAccent,
            title: Text(languageService.translate('govt_crop_prices')),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageService.translate('minimum_support_prices'),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                
                // How to Use Government Scheme Links
                Card(
                  color: Colors.green[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.help_outline,
                              color: Colors.green[700],
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              languageService.translate('how_to_use_schemes'),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          languageService.translate('how_to_use_schemes_desc'),
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                ...cropPrices.map((item) => Card(
                  color: Theme.of(context).cardColor,
                  child: ListTile(
                    leading: const Icon(Icons.agriculture),
                    title: Text(languageService.translate(cropNameToKey(item['crop'] ?? ''))),
                    subtitle: Text('${languageService.translate('msp')}: ₹${item['price']} ${languageService.translate('per_quintal')}'),
                  ),
                )),
                const SizedBox(height: 30),
                Text(
                  languageService.translate('calculate_total_crop_value'),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: languageService.translate('select_crop'),
                    border: OutlineInputBorder(),
                  ),
                  value: selectedCrop,
                  items: cropPrices
                      .map((item) => DropdownMenuItem(
                            value: item['crop'],
                            child: Text(languageService.translate(cropNameToKey(item['crop'] ?? ''))),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCrop = value;
                      totalAmount = null;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: quantityController,
                  decoration: InputDecoration(
                    labelText: languageService.translate('enter_quantity_quintals'),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    enteredQuantity = double.tryParse(value);
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _calculateAmount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                  ),
                  child: Text(languageService.translate('calculate_amount')),
                ),
                if (totalAmount != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    '${languageService.translate('total_amount')}: ₹${totalAmount!.toStringAsFixed(2)}',
                    style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageService.translate('government_schemes_farmers'),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_filteredSchemes.length} ${languageService.translate('schemes_count')}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orangeAccent[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: languageService.translate('search_schemes'),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _filterSchemes('');
                            },
                          )
                        : null,
                    border: const OutlineInputBorder(),
                    hintText: languageService.translate('search_schemes_hint'),
                  ),
                  onChanged: _filterSchemes,
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                if (_filteredSchemes.isEmpty && _searchController.text.isNotEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${languageService.translate('no_schemes_found')} "${_searchController.text}"',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ..._filteredSchemes.map((scheme) => Card(
                  color: Theme.of(context).cardColor,
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: _isLaunchingURL ? null : () => _launchURL(scheme['url']!),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: _isLaunchingURL
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.orangeAccent,
                                      ),
                                    ),
                                  )
                                : const Icon(
                                    Icons.account_balance,
                                    color: Colors.orangeAccent,
                                    size: 24,
                                  ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _localizedSchemeTitle(scheme, languageService),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.orangeAccent.withOpacity(0.5),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    scheme['category'] ?? '',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.orangeAccent[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _localizedSchemeDesc(scheme, languageService),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      _isLaunchingURL ? Icons.hourglass_empty : Icons.open_in_new,
                                      size: 16,
                                      color: _isLaunchingURL ? Colors.grey : Colors.orangeAccent,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _isLaunchingURL ? languageService.translate('opening') : languageService.translate('tap_to_open_website'),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _isLaunchingURL ? Colors.grey : Colors.orangeAccent,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            _isLaunchingURL ? Icons.hourglass_empty : Icons.arrow_forward_ios,
                            color: _isLaunchingURL ? Colors.grey : Colors.grey[400],
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        _launchURL('https://agricoop.nic.in/en/schemes'),
                    icon: const Icon(Icons.open_in_new),
                    label: Text(languageService.translate('see_more_schemes')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
