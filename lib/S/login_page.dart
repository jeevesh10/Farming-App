import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:annagrah/home_page.dart';
import 'sign_up_page.dart';
import 'forgot_password_page.dart';
import '../services/language_service.dart';
import '../widgets/language_selector.dart';

class LoginPage extends StatefulWidget {
  final String? registeredEmail;
  final String? registeredPassword;

  const LoginPage({super.key, this.registeredEmail, this.registeredPassword});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageService.translate('welcome_back'),
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      languageService.translate('please_login'),
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: languageService.translate('email'),
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: languageService.translate('password'),
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    if (_errorMessage.isNotEmpty)
                      Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()),
                          );
                        },
                        child: Text(languageService.translate('forgot_password'),
                            style: TextStyle(color: Colors.orangeAccent)),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_emailController.text == widget.registeredEmail &&
                              _passwordController.text ==
                                  widget.registeredPassword) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          } else {
                            setState(() {
                              _errorMessage = languageService.translate('invalid_credentials');
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent),
                        child: Text(languageService.translate('login')),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(languageService.translate('dont_have_account'),
                            style: TextStyle(color: Colors.black)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpPage()),
                            );
                          },
                          child: Text(languageService.translate('signup'),
                              style: TextStyle(color: Colors.orangeAccent)),
                        ),
                      ],
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
