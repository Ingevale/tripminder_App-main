// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:tripminder/login/login_widget.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  bool _passwordVisibility1 = false;
  bool _passwordVisibility2 = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  Future<void> _register() async {
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      // Muestra un mensaje de error si algún campo está vacío
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

    if (_passwordController.text != _confirmPasswordController.text) {
      // Muestra un mensaje de error si las contraseñas no coinciden
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Las contraseñas no coinciden',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
      return;
    }

    if (_passwordController.text.length < 8) {
      // Muestra un mensaje de error si la contraseña tiene menos de 8 caracteres
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'La contraseña debe tener al menos 8 caracteres',
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
      // Crear usuario en Firebase Auth
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Almacena el nombre del usuario en Firestore
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userCredential.user!.uid)
          .set({'nombre': _fullNameController.text});

      // Registro exitoso, muestra el mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Registro Exitoso!',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

      await Future.delayed(const Duration(seconds: 1));

      // Navegar a la pantalla de inicio de sesión
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginWidget()),
      );
    } catch (e) {
      // El registro falló, maneja el error (por ejemplo, muestra un mensaje de error).
      print("Registration failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registration failed: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF363062), // Cambia al color deseado
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: const BoxDecoration(
                color: Color(0xFF363062), // Cambia al color deseado
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 100, // Ajusta el ancho según sea necesario
                    height: 100, // Ajusta la altura según sea necesario
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/logoNew.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Espaciado entre la imagen y el texto
                  Text(
                    'TripMinder',
                    style: GoogleFonts.oswald(
                      color: const Color(0xFFF5E8C7), // Color del texto
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
                    controller: _fullNameController,
                    obscureText: false,
                    style: const TextStyle(
                      color: Color(0xFFF5E8C7), // Color del texto
                    ),
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: const TextStyle(color: Color(0xFFF5E8C7)),
                      hintText: 'Enter your name here...',
                      hintStyle: const TextStyle(color: Color(0xFFF5E8C7)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFF5E8C7)),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    // Añade validador si es necesario
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    obscureText: false,
                    style: const TextStyle(
                      color: Color(0xFFF5E8C7), // Color del texto
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
                    // Añade validador si es necesario
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_passwordVisibility1,
                    style: const TextStyle(
                      color: Color(0xFFF5E8C7), // Color del texto
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
                        onTap: () =>
                            setState(() => _passwordVisibility1 = !_passwordVisibility1),
                        child: Icon(
                          _passwordVisibility1
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xFFF5E8C7),
                        ),
                      ),
                    ),
                    // Añade validador si es necesario
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_passwordVisibility2,
                    style: const TextStyle(
                      color: Color(0xFFF5E8C7), // Color del texto
                    ),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(color: Color(0xFFF5E8C7)),
                      hintText: 'Confirm password here...',
                      hintStyle: const TextStyle(color: Color(0xFFF5E8C7)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFF5E8C7)),
                      ),
                      suffixIcon: InkWell(
                        onTap: () =>
                            setState(() => _passwordVisibility2 = !_passwordVisibility2),
                        child: Icon(
                          _passwordVisibility2
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xFFF5E8C7),

                        ),
                      ),
                    ),
                    // Añade validador si es necesario
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF435585), // Color secundario
                    ),
                    child: const Text(
                      'Crear cuenta',
                      style: TextStyle(
                        color: Color(0xFFF5E8C7), // Color del texto
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
