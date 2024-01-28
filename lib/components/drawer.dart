import 'package:flutter/material.dart';

class NavDrawerDemo extends StatelessWidget {
  const NavDrawerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: const Text(
        'Tripminder',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Colors.grey, 
        ),
      ),
      currentAccountPicture: CircleAvatar(
        child: Image.asset(
          'assets/images/ic_launcher_new',
          width: 60.0,
          height: 60.0,
        ),
      ),
      accountEmail: null,
       decoration: const BoxDecoration(
        color: const Color.fromARGB(255, 65, 111, 223)
      ),
    );

    final drawerItems = ListView(
      children: [
        drawerHeader,
        ListTile(
          title: const Text('Conductor'),
          leading: const Icon(Icons.attribution),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Gerente de Finanzas'),
          leading: const Icon(Icons.assignment_ind_rounded),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Page 3'),
          leading: const Icon(Icons.airport_shuttle),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    return Drawer(
      child: drawerItems,
    );
  }
}
