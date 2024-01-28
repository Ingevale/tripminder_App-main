// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tripminder/login/login_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('isSessionActive'); // Eliminar la información de la sesión

      await FirebaseAuth.instance.signOut();

      // Navegar a la pantalla de inicio de sesión después de cerrar sesión
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginWidget()),
      );
    } catch (e) {
      print("Error al cerrar sesión: $e");
    }
  }

  Future<void> _deleteAccount(BuildContext context) async {
    try {
      // Obtener el usuario actualmente autenticado
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Eliminar el usuario
        await user.delete();

        // Navegar a la pantalla de inicio de sesión después de eliminar la cuenta
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginWidget()),
        );
      }
    } catch (e) {
      print("Error al eliminar la cuenta: $e");
      // Manejar el error según tus necesidades (puedes mostrar un mensaje al usuario, etc.)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Editar Perfil'),
            leading: Icon(Icons.edit),
            // Agrega la lógica para la pantalla de edición de perfil aquí
          ),
          const ListTile(
            title: Text('Ver Historial de Informes'),
            leading: Icon(Icons.history),
            // Agrega la lógica para la pantalla de historial de informes aquí
          ),
          ListTile(
            title: const Text('Cambiar a Dark Mode'),
            leading: const Icon(Icons.dark_mode),
            trailing: Switch(
              value: false, // Puedes manejar el estado de dark mode aquí
              onChanged: (value) {
                // Agrega la lógica para cambiar el modo oscuro aquí
              },
            ),
          ),
          ListTile(
            title: const Text('Cerrar Sesión'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Cerrar Sesión'),
                    content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await _signOut(context);
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            title: const Text('Eliminar Cuenta'),
            leading: const Icon(Icons.delete),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Eliminar Cuenta'),
                    content: const Text('¿Estás seguro de que deseas eliminar tu cuenta?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await _deleteAccount(context);
                        },
                        child: const Text('Eliminar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
