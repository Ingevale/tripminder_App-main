

// // ignore_for_file: use_key_in_widget_constructors

// import 'package:flutter/material.dart';
// import '../signup/signUp_screen.dart';
// import '../login/login_screen.dart';

// class Pantalla2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox.expand(
//         child: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/fondoInicio.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Texto "TripMinder" con sombreado y resaltado en negritas
//               const Padding(
//                 padding: EdgeInsets.only(bottom: 20.0),
//                 child: Text(
//                   'TripMinder',
//                   style: TextStyle(
//                     fontSize: 45.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     shadows: [
//                       Shadow(
//                         blurRadius: 10.0,
//                         color: Colors.black,
//                         offset: Offset(2.0, 2.0),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40), // Espacio entre el texto y los botones
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Botón "Iniciar Sesión"
//                   ElevatedButton(
//                     onPressed: () {
//                       // Navegar a Signup cuando se presiona el botón
//                       Navigator.of(context).push(_createRouteToSignup());
//                     },
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.black, backgroundColor: Colors.white,
//                       padding:
//                           const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                       textStyle:
//                           const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     child: const Text('Iniciar Sesión'),
//                   ),
//                   const SizedBox(width: 20), // Espacio entre los botones
//                   // Botón "Empresa Nueva"
//                   ElevatedButton(
//                     onPressed: () {
//                       // Navegar a Pantalla3 cuando se presiona el botón
//                       Navigator.of(context).push(_createRouteToPantalla3());
//                     },
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.black, backgroundColor: Colors.white,
//                       padding:
//                           const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                       textStyle:
//                           const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     child: const Text('Crear Cuenta'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Route _createRouteToPantalla3() {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => const RegisterWidget(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(1.0, 0.0);
//         const end = Offset.zero;
//         const curve = Curves.easeInOut;

//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//         var offsetAnimation = animation.drive(tween);

//         return SlideTransition(position: offsetAnimation, child: child);
//       },
//     );
//   }

//   Route _createRouteToSignup() {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => RegisterWidget(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(0.0, -1.0);
//         const end = Offset.zero;
//         const curve = Curves.easeInOut;

//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//         var offsetAnimation = animation.drive(tween);

//         return SlideTransition(position: offsetAnimation, child: child);
//       },
//     );
//   }
// }
