
import 'package:flutter/material.dart';
import 'package:mediclinique/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F5),
      appBar: AppBar(
        backgroundColor: Color(0xFF673AB7),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Connexion', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Color(0xFF673AB7),
                  padding: EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Text(
                      'Se connecter',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informations de connexion',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              errorText: _errorMessage,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Mot de passe',
                              errorText: _errorMessage,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF673AB7),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Se connecter',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'Créer un compte',
                      style: TextStyle(
                        color: Color(0xFF673AB7),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  
  Future<void> _login() async {
  setState(() {
    _isLoading = true;
    _errorMessage = null;
  });

  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();

  try {
    String? loginError = await _authService.loginUser(email, password);
    if (loginError != null) {
      setState(() {
        _errorMessage = loginError;
      });
      return;
    }

    String? userId = _authService.getCurrentUserId();
    if (userId != null) {
      String? role = await _authService.getUserRole(userId);
      print("$role");
     switch(role) {
  // case 'admin':
  //   Navigator.pushReplacementNamed(context, '/admin_home');
  //   break;
  case 'clinic':
    Navigator.pushReplacementNamed(context, '/clinique_home');
    break;
  case 'medecin':
    Navigator.pushReplacementNamed(context, '/medecin_home');
    break;
  // case 'patient':
  //   Navigator.pushReplacementNamed(context, '/patient_home');
  //   break;
  default:
    setState(() {
      _errorMessage = 'Rôle utilisateur non reconnu: $role';
    });
}
    } else {
      setState(() {
        _errorMessage = 'Impossible de récupérer l\'ID de l\'utilisateur';
      });
    }
  } on FirebaseAuthException catch (e) {
    setState(() {
      _errorMessage = e.message;
    });
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}
}