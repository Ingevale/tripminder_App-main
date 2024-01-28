// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class FormularioRuta extends StatefulWidget {
  @override
  _FormularioRutaState createState() => _FormularioRutaState();
}

class _FormularioRutaState extends State<FormularioRuta> {
  DateTime? fechaRegistro;
  List<Map<String, String>> paradas = [];

  final List<String> conductores = [
    // Aquí puedes agregar la lista de conductores disponibles
  ];

  String conductorSeleccionado = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registrar una nueva ruta',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 65, 111, 223),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle('ID del vehiculo'),
            _buildTextField('Ingrese el ID del vehiculo'),
            SizedBox(height: 16.0),
            _buildSectionTitle('Fecha de Registro'),
            _buildDateField(fechaRegistro, (DateTime? date) {
              setState(() {
                fechaRegistro = date;
              });
            }),
            SizedBox(height: 16.0),
            _buildSectionTitle('Conductor'),
            _buildDropdownButton(
              conductores,
              conductorSeleccionado,
              (String? value) {
                if (value != null) {
                  setState(() {
                    conductorSeleccionado = value;
                  });
                }
              },
            ),
            SizedBox(height: 16.0),
            _buildSectionTitle('Paradas'),
            _buildParadasFields(),
            SizedBox(height: 24.0),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para agregar la ruta
                    // Puedes acceder a los valores de los campos usando controladores o mediante la obtención de los valores directamente
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF223688),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Registrar Ruta',
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
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  Widget _buildParadasFields() {
    return Column(
      children: [
        for (int i = 0; i < paradas.length; i++)
          Column(
            children: [
              _buildParadaField(paradas[i], i),
              SizedBox(
                  height:
                      8), // Agrega un espacio vertical entre los campos de parada
            ],
          ),
        InkWell(
          onTap: () {
            setState(() {
              paradas.add({});
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.add),
                SizedBox(width: 8),
                Text('Agregar Parada'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildParadaField(Map<String, String> parada, int index) {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            'Número de Calle',
            TextInputType.number,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: _buildTextField('Nombre de Calle'),
        ),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              paradas.removeAt(index);
            });
          },
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FormularioRuta(),
  ));
}
