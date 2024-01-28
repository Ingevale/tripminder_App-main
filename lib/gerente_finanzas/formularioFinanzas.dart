// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FormularioFinanzas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro de Finanzas',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF223688),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle('Nombre'),
            _buildTextField('Ingrese el nombre'),
            SizedBox(height: 16.0),
            _buildSectionTitle('Correo Electrónico'),
            _buildTextField('Ingrese el correo electrónico', TextInputType.emailAddress),
            SizedBox(height: 16.0),
            _buildSectionTitle('Contraseña'),
            _buildTextField('Ingrese la contraseña', TextInputType.visiblePassword),
            SizedBox(height: 16.0),
            _buildSectionTitle('Número de Teléfono'),
            _buildTextField('Ingrese el número de teléfono', TextInputType.phone),
            SizedBox(height: 24.0),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para manejar los datos financieros
                    // Puedes acceder a los valores de los campos usando controladores o mediante la obtención de los valores directamente
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF223688),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Registrar Finanzas', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF223688),
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, [TextInputType? keyboardType]) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: (hintText == 'Ingrese la contraseña'), // Para ocultar la contraseña
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FormularioFinanzas(),
  ));
}
