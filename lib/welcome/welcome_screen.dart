import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:tripminder/signup/signUp_screen.dart';
import 'package:tripminder/login/login_widget.dart';

void main() {
  runApp(const MaterialApp(
    home: SplashScreenWidget(),
  ));
}

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget>
    with TickerProviderStateMixin {
  late AnimationController _imageAnimationController;

  @override
  void initState() {
    super.initState();

    _imageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _playAnimations();
  }

  void _playAnimations() {
    _imageAnimationController.forward();

    // Añade un temporizador para esperar 3 segundos antes de navegar
    Timer(
      const Duration(seconds: 3),
      () {
        // Navega a la pantalla de registro (SignUpScreen)
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginWidget()),
        );
      },
    );
  }

  @override
  void dispose() {
    _imageAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363062), // #363062
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _imageAnimationController.drive(
                CurveTween(curve: Curves.easeInOut),
              ),
              child: Image.asset(
                'assets/images/logoNew.png',
                width: 300,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
