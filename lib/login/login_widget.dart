// login_widget.dart
// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripminder/home/homeGerente.dart';
import 'package:tripminder/signup/signUp_screen.dart';
import 'package:tripminder/login/resetPassword_screen.dart';
// ignore: unused_import
import 'package:tripminder/conductores/conductor_page.dart';
import 'package:tripminder/conductores/formularioConductor.dart';


class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool _passwordVisibility = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }


  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

Future<void> _login() async {
  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Llena todos los campos',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return;
  }

  try {
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    // Obtén información del usuario desde Firestore
    final userData = await FirebaseFirestore.instance
        .collection('conductores')
        .doc(userCredential.user!.uid)
        .get();

    // Verifica el rol y navega a la página correspondiente
    if (userData.exists && userData['rol'] == 'conductor') {
      // Si el rol es 'conductor', navega a la página de conductor
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FormularioConductor()),
      );
    } else {
      // En este punto puedes agregar lógica para otros roles si es necesario
      // Por defecto, navega a la página HomeGerente si el rol no es 'conductor'
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeGerente()),
      );
    }
  } catch (e) {
    print("Login failed: $e");
    String errorMessage = "Inicio de sesión fallido: $e";

    if (e is FirebaseAuthException) {
      if (e.code == 'user-not-found') {
        errorMessage = 'Cuenta no existente';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage, style: const TextStyle(color: Colors.red)),
          ),
        );
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Correo o contraseña incorrectos';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage, style: const TextStyle(color: Colors.red)),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage, style: const TextStyle(color: Colors.red)),
        ),
      );
    }
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF363062),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: const BoxDecoration(
                color: Color(0xFF363062),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/logoNew.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'TripMinder',
                    style: GoogleFonts.oswald(
                      color: const Color(0xFFF5E8C7),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
                    controller: _emailController,
                    obscureText: false,
                    style: const TextStyle(
                      color: Color(0xFFF5E8C7),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: const TextStyle(color: Color(0xFFF5E8C7)),
                      hintText: 'Enter your email here...',
                      hintStyle: const TextStyle(color: Color(0xFFF5E8C7)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFF5E8C7)),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_passwordVisibility,
                    style: const TextStyle(
                      color: Color(0xFFF5E8C7),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Color(0xFFF5E8C7)),
                      hintText: 'Enter your password here...',
                      hintStyle: const TextStyle(color: Color(0xFFF5E8C7)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFF5E8C7)),
                      ),
                      suffixIcon: InkWell(
                        onTap: () => setState(
                          () => _passwordVisibility = !_passwordVisibility,
                        ),
                        child: Icon(
                          _passwordVisibility
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xFFF5E8C7),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: const Color(0xFFF5E8C7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF435585),
                    ),
                    child: const Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        color: Color(0xFFF5E8C7),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                          color: Color(0xFF818FB4),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterWidget(),
                            ),
                          );
                        },
                        child: const Text(
                          'SignUp',
                          style: TextStyle(
                            color: Color(0xFFF5E8C7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
