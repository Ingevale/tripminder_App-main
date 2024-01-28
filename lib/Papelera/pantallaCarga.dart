// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import '../home/homeGerente.dart'; // Asegúrate de importar la pantalla signup.dart

// class PantallaCarga extends StatefulWidget {
//   @override
//   _PantallaCargaState createState() => _PantallaCargaState();
// }

// class _PantallaCargaState extends State<PantallaCarga>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();

//     // Configura el controlador de animación con duración de 2 segundos
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );

//     // Inicia la animación al construir el widget
//     _controller.repeat(
//         reverse: true); // Hace que la animación se repita en bucle

//     // Espera 5 segundos y luego navega a signup.dart
//     Future.delayed(const Duration(seconds: 5), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomeGerente(), // Asegúrate de tener la ruta correcta
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.asset(
//             'assets/images/fondoInicio.jpg',
//             fit: BoxFit.cover,
//             height: double.infinity,
//             width: double.infinity,
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Usa un AnimatedBuilder para animar el texto con parpadeo
//                 AnimatedBuilder(
//                   animation: _controller,
//                   builder: (context, child) {
//                     return Opacity(
//                       opacity: _controller.value,
//                       child: const Text(
//                         'TripMinder',
//                         style: TextStyle(
//                           fontSize: 45.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           shadows: [
//                             Shadow(
//                               blurRadius: 10.0,
//                               color: Colors.black,
//                               offset: Offset(2.0, 2.0),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Asegúrate de liberar los recursos del controlador de animación al destruir el widget
//     _controller.dispose();
//     super.dispose();
//   }
// }
