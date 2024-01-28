// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: FormularioVehiculo(),
  ));
}
class FormularioVehiculo extends StatefulWidget {
  const FormularioVehiculo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormularioVehiculoState createState() => _FormularioVehiculoState();
}

class _FormularioVehiculoState extends State<FormularioVehiculo> {
  DateTime? fechaRegistro;
  DateTime? ultimaFechaMantenimiento;

  final List<String> tiposDeVehiculo = [
    'Furgoneta de carga',
    'Camiones de reparto',
    'Camiones refrigerados',
    'Vehículos especializados',
  ];

  String tipoDeVehiculoSeleccionado = 'Furgoneta de carga';
  String tipoDeCombustibleSeleccionado = 'Gasolina';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registrar un nuevo vehículo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF223688),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle('Tipo de Vehículo'),
            _buildDropdownButton(tiposDeVehiculo, tipoDeVehiculoSeleccionado,
                (String? value) {
              if (value != null) {
                setState(() {
                  tipoDeVehiculoSeleccionado = value;
                });
              }
            }),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Placas'),
            _buildTextField('Ingrese las placas'),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Fecha de Registro'),
            _buildDateField(fechaRegistro, (DateTime? date) {
              setState(() {
                fechaRegistro = date;
              });
            }),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Última Fecha de Mantenimiento'),
            _buildDateField(ultimaFechaMantenimiento, (DateTime? date) {
              setState(() {
                ultimaFechaMantenimiento = date;
              });
            }),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Capacidad del Tanque'),
            _buildTextField(
                'Ingrese la capacidad del tanque', TextInputType.number),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Tipo de Combustible'),
            _buildDropdownButton(['Gasolina', 'Diésel', 'Eléctrico'],
                tipoDeCombustibleSeleccionado, (String? value) {
              if (value != null) {
                setState(() {
                  tipoDeCombustibleSeleccionado = value;
                });
              }
            }),
            const SizedBox(height: 24.0),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para agregar el vehículo
                    // Puedes acceder a los valores de los campos usando controladores o mediante la obtención de los valores directamente
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF223688),
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Registrar Vehículo',
                        style: TextStyle(color: Colors.white)),
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
        style: const TextStyle(
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

  Widget _buildDropdownButton(
      List<String> items, String value, void Function(String?) onChanged) {
    return DropdownButton<String>(
      value: value,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }

  Widget _buildDateField(
      DateTime? selectedDate, void Function(DateTime?) onDateSelected) {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null && pickedDate != selectedDate) {
          onDateSelected(pickedDate);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate != null
                  ? '${selectedDate.toLocal()}'.split(' ')[0]
                  : 'Seleccione la fecha',
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}


