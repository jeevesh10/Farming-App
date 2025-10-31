import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/connectivity_service.dart';
import '../services/language_service.dart';

class NetworkAwareWidget extends StatelessWidget {
  final Widget child;
  final Widget? offlineWidget;

  const NetworkAwareWidget({
    Key? key,
    required this.child,
    this.offlineWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ConnectivityService, LanguageService>(
      builder: (context, connectivityService, languageService, _) {
        if (!connectivityService.isConnected) {
          return offlineWidget ?? _buildOfflineWidget(context, languageService);
        }
        return child;
      },
    );
  }

  Widget _buildOfflineWidget(BuildContext context, LanguageService languageService) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              languageService.translate('no_internet'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              languageService.translate('internet_required'),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<ConnectivityService>().checkInternetConnection();
              },
              icon: const Icon(Icons.refresh),
              label: Text(languageService.translate('retry')),
            ),
          ],
        ),
      ),
    );
  }
}


