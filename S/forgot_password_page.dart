import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';
import '../widgets/language_selector.dart';
import 'S/../login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  String _message = '';

  void _sendResetLink() {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        _message = 'Please enter your registered email';
      });
      return;
    }

    // Simulating email sending process
    setState(() {
      _message = 'A reset link has been sent to $email';
    });

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
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
          ),
          body: Stack(
            children: [
              // Centered Background Image
              Center(
                child: Opacity(
                  opacity: 0.2, // Light opacity for readability
                  child: Image.asset(
                    "assets/image/logo.png", // Ensure the correct path
                    width: 200,
                    height: 200,
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      languageService.translate('forgot_password'),
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      languageService.translate('enter_email_for_reset'),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: languageService.translate('email'),
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _sendResetLink,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent),
                        child: Text(languageService.translate('send_reset_link')),
                      ),
                    ),
                    SizedBox(height: 20),
                    if (_message.isNotEmpty)
                      Text(
                        _message,
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
