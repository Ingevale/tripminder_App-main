
// ignore_for_file: prefer_null_aware_operators, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../home/homeGerente.dart';

class FormularioConductor extends StatefulWidget {
  const FormularioConductor({super.key});

  @override
  _FormularioConductorState createState() => _FormularioConductorState();
}

class _FormularioConductorState extends State<FormularioConductor> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _licenciaController = TextEditingController();
  final TextEditingController _rolController = TextEditingController(text: 'conductor');
  DateTime? _fechaSeleccionada;
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registrar un nuevo conductor',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF223688),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle('Nombre completo del Conductor'),
              _buildTextField('Ingrese el nombre completo', _nombreController),
              const SizedBox(height: 16.0),
              _buildSectionTitle('Correo electrónico'),
              _buildTextField('Ingrese el correo electrónico',
                  _correoController, TextInputType.emailAddress),
              const SizedBox(height: 16.0),
              _buildSectionTitle('Contraseña'),
              _buildTextField('Ingrese la contraseña', _contrasenaController,
                  TextInputType.visiblePassword),
              const SizedBox(height: 16.0),
              _buildSectionTitle('Número de teléfono'),
              _buildTextField('Ingrese el número de teléfono',
                  _telefonoController, TextInputType.phone),
              const SizedBox(height: 16.0),
              _buildSectionTitle('Número de licencia de conducir'),
              _buildTextField('Ingrese el número de licencia de conducir',
                  _licenciaController),
              const SizedBox(height: 16.0),
              _buildSectionTitle('Fecha de vencimiento'),
              _buildDateField(_fechaSeleccionada, (DateTime? date) {
                setState(() {
                  _fechaSeleccionada = date;
                });
              }),
              const SizedBox(height: 16.0),
              _buildSectionTitle('Foto del Conductor'),
              _buildImagePicker(),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  _registrarConductor();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF223688),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Registrar Conductor',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF223688),
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller,
      [TextInputType? keyboardType]) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: (hintText == 'Ingrese la contraseña'),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  Widget _buildDateField(
      DateTime? selectedDate, void Function(DateTime?) onDateSelected) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: TextEditingController(
              text: selectedDate != null
                  ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                  : '',
            ),
            enabled: false,
            decoration: InputDecoration(
              hintText: 'Seleccione la fecha',
              hintStyle: TextStyle(color: Colors.grey[500]),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        ElevatedButton(
          onPressed: () {
            _seleccionarFecha();
          },
          child: const Text('Seleccionar Fecha'),
        ),
      ],
    );
  }

  Future<void> _seleccionarFecha() async {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (fechaSeleccionada != null && fechaSeleccionada != _fechaSeleccionada) {
      setState(() {
        _fechaSeleccionada = fechaSeleccionada;
      });
    }
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        if (_image != null)
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: FileImage(_image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {
            _seleccionarFotoConductor();
          },
          child: const Text('Seleccionar Foto del Conductor'),
        ),
      ],
    );
  }

  Future<void> _seleccionarFotoConductor() async {
    try {
      final pickedFile =
          await ImagePicker().getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error al seleccionar la foto del conductor: $e');
    }
  }

  Future<void> _registrarConductor() async {
    try {
      print('Intentando registrar conductor...');

      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _correoController.text,
        password: _contrasenaController.text,
      );

      if (_image != null) {
        final String imagePath =
            'conductores/${userCredential.user!.uid}/profile_picture.jpg';
        final Reference storageReference =
            FirebaseStorage.instance.ref().child(imagePath);

        await storageReference.putFile(_image!);

        final String downloadURL = await storageReference.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('conductores')
            .doc(userCredential.user!.uid)
            .set({
          'nombre': _nombreController.text,
          'correo': _correoController.text,
          'telefono': _telefonoController.text,
          'licencia': _licenciaController.text,
          'fechaVencimiento': _fechaSeleccionada != null
              ? _fechaSeleccionada!.toIso8601String()
              : null,
          'imagenURL': downloadURL,
          'rol': _rolController.text,
        });

        // Después de registrar al conductor, navega a la pantalla 'homeGerente.dart'
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeGerente()),
        );
      }

      print('Registro de conductor exitoso');
    } on FirebaseAuthException catch (e) {
      print('Error en el registro del conductor: $e');
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: FormularioConductor(),
  ));
}
