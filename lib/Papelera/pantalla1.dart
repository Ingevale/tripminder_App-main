// // ignore_for_file: prefer_const_constructors

// import 'dart:async'; // Importa la biblioteca para usar Timer

// import 'package:flutter/material.dart';

// class Pantalla1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Establece un temporizador de 3 segundos
//     Timer(Duration(seconds: 3), () {
//       // Navega a la pantalla 'pantalla3.daart'
//       Navigator.pushReplacementNamed(context, '/pantalla3');
//     });

//     return Scaffold(
//       body: Container(
//         // Configura el fondo azul
//         color: const Color.fromARGB(255, 61, 33, 243),
//         // Configura la disposición de la columna
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Usa un Expanded para centrar la imagen verticalmente
//             Expanded(
//               child: Container(
//                 alignment: Alignment.center,
//                 child: Image.asset(
//                   'assets/images/LogoTripMinder.png',
//                   width: 200, // Ajusta el ancho según tus necesidades
//                 ),
//               ),
//             ),

//             // Agrega un espacio entre la imagen y el texto
//             SizedBox(height: 20),

//             // Usa un Container para centrar el texto
//             Container(
//               alignment: Alignment.center,
//               child: Text(
//                 'TripMinder',
//                 style: TextStyle(
//                   color: Colors.white, // Configura el color del texto
//                   fontSize:
//                       24, // Ajusta el tamaño del texto según tus necesidades
//                   fontWeight:
//                       FontWeight.bold, // Hace que el texto esté en negrita
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
