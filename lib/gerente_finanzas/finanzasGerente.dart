// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import '../home/homeGerente.dart';
import '../vehiculos/vehiculosGerente.dart';
import 'formularioFinanzas.dart';
import '../rutas/rutaGerente.dart';
import '../perfil/perfilGerente.dart';

void main() {
  runApp(FinanzasGerente());
}

class FinanzasGerente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF223688),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;

  late AnimationController notchAndCornersAnimation;

  @override
  void initState() {
    super.initState();
    notchAndCornersAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    notchAndCornersAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TripMinder',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Image.asset(
              'assets/images/LogoTripMinder.png',
              height: 30,
              width: 30,
            ),
          ],
        ),
        backgroundColor: Color(0xFF223688),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF223688),
              ),
              child: Text(
                'TripMinder',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Conductores'),
              onTap: () {
                // Navegar a 'HomeGerente.dart'
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomeGerente(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Gerente de finanzas'),
              onTap: () {
                // Navegar a 'FinanzasGerente'
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FinanzasGerente(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Vehiculos'),
              onTap: () {
                // Navegar a 'VehiculosGerente'
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VehiculosGerente(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormularioFinanzas()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFFff4081),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 3,
        tabBuilder: (int index, bool isActive) {
          IconData iconData = index == 0
              ? Icons.home
              : index == 1
                  ? Icons.location_on
                  : Icons.person;

          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? Color(0xFF223688) : Colors.white,
                ),
              ),
              Icon(
                iconData,
                size: 30,
                color: isActive ? Colors.white : Color(0xFF223688),
              ),
            ],
          );
        },
        activeIndex: _currentIndex,
        splashColor: Colors.blue,
        notchAndCornersAnimation: notchAndCornersAnimation,
        splashSpeedInMilliseconds: 300,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RutaGerente(),
              ),
            );
          } else if (index == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          }
        },
        backgroundColor: Color(0xFF223688),
      ),
    );
  }
}
