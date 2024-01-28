import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../conductores/formularioConductor.dart';
// import '../gerente_finanzas/finanzasGerente.dart';
// import '../vehiculos/vehiculosGerente.dart';
import 'package:tripminder/components/barraNavegacion.dart';
import 'package:tripminder/rutas/rutaGerente.dart';
import 'package:tripminder/perfil/perfilGerente.dart';
import 'package:tripminder/components/drawer.dart';

class HomeGerente extends StatelessWidget {
  const HomeGerente({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Conductores',
      theme: ThemeData(
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8E8FFA),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'TripMinder',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Image.asset(
              'assets/images/LogoTripMinder.png',
              height: 30,
              width: 30,
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 65, 111, 223),
      ),
       drawer: NavDrawerDemo(
        
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FormularioConductor()),
          );
        },
        backgroundColor: const Color(0xFF7752FE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream:
            FirebaseFirestore.instance.collection('conductores').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay conductores registrados'));
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final conductor = snapshot.data!.docs[index]
                    as QueryDocumentSnapshot<Map<String, dynamic>>;
                return _buildConductorTile(conductor);
              },
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 2:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
              break;
            case 1:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RutaGerente(),
                ),
              );
              break;
          }
        },
      ),
      backgroundColor: const Color(0xFF8E8FFA),
    );
  }

  Widget _buildConductorTile(
      QueryDocumentSnapshot<Map<String, dynamic>> conductor) {
    final imagenURL = conductor.data()['imagenURL'] as String?;
    final nombre = conductor.data()['nombre'] as String?;

    if (imagenURL != null && nombre != null) {
      return Card(
        elevation: 5,
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              imagenURL,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              nombre,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  void main() {
    runApp(const MaterialApp(
      home: HomeGerente(),
    ));
  }
}
