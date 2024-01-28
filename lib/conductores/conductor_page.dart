// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tripminder/home/dashboard.dart';
import 'package:tripminder/perfil/profile.dart';
import 'package:tripminder/conductores/formularioConductor.dart';

void main() {
  runApp(ConductorEsPage());
}

class ConductorEsPage extends StatelessWidget {
  const ConductorEsPage({Key? key});

  @override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Bottom Navigation Demo',
    theme: ThemeData(
      primaryColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 65, 111, 223),
        toolbarHeight: 80.0, // Ajusta la altura según tus necesidades
      ),
    ),
    home: ConductorScreen(),
  );
}
}

class ConductorScreen extends StatefulWidget {
  const ConductorScreen({Key? key});

  @override
  _ConductorScreenState createState() => _ConductorScreenState();
}

class _ConductorScreenState extends State<ConductorScreen> with TickerProviderStateMixin {
  int _currentIndex = 1; // Iniciar con el ícono de ubicación seleccionado

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
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 65, 111, 223),
        title: Row(
          children: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                "Conductores",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 15),
            Image.asset(
              'assets/images/ic_launcher_new.png',
              height: 50,
              width: 50,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormularioConductor()),
          );
        },
        backgroundColor: Color(0xFFff4081),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      drawer: CustomDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DashboardPage(),
              ),
            );
          } else if (index == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Profile(),
              ),
            );
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_sharp),
            label: 'Routes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 65, 111, 223),
            ),
            child: Text(
              'Tripminder',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Conductores'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConductorScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Gerente de operaciones'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Informes'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
