import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tripminder/home/dashboard.dart';
import 'package:tripminder/rutas/rutaGerente.dart';
import 'package:tripminder/conductores/conductor_page.dart';
void main() {
  runApp(Profile());
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String tProfileImage;
  final double tDefaultSize = 16.0;
  bool isDarkMode = false;

  _ProfileState() : tProfileImage = tProfileImageConstant;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 65, 111, 223),
          title: Row(
            children: [
              Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(
                      Icons.sort,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              SizedBox(width: 15),
              Text(
                "Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
              icon: Icon(
                isDarkMode ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(image: AssetImage(tProfileImage)),
                  ),
                ),
                const SizedBox(height: 10),
                // ignore: deprecated_member_use
                Text("Administrador", style: Theme.of(context).textTheme.headline6),
                Text(
                  "superAdmin@codingwith.com",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 65, 111, 223),
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),

                ProfileMenuWidget(title: "Settings", icon: LineAwesomeIcons.cog, onPressed: () {}),
                ProfileMenuWidget(title: "user management", icon: LineAwesomeIcons.wallet, onPressed: () {}),
                const Divider(color: Colors.grey),
                const SizedBox(height: 10),
                ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info, onPressed: () {}),
                ProfileMenuWidget(
                  title: "Logout", 
                  icon: LineAwesomeIcons.alternate_sign_in, 
                  textColor: Colors.red,
                  endIcon: false,
                  onPressed: (){}),
              ],
            ),
          ),
        ),
        drawer: CustomDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: 2,
            onTap: (index) {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              }else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RutaGerente()),
              );
            }
          },
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Container(
        width: 40, 
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromARGB(255, 52, 7, 255).withOpacity(0.1),
        ),
        child: Icon(icon, color:Color.fromARGB(255, 52, 7, 255)),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodySmall?.apply(color: textColor)),
      trailing: endIcon? Container(
        width: 30, 
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Icon( LineAwesomeIcons.angle_right, size: 18.0, color:Colors.grey)) : null,
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 65, 111, 223),
            ),
            child: Text(
              'Tripminder',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Conductores'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConductorScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Gerente de operaciones'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Informes'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

const String tProfileImageConstant = "assets/images/perfil.png";

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: const Color(0xFF8E8FFA),
      unselectedItemColor: Colors.grey[600],
      currentIndex: currentIndex,
      onTap: onTap,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on_sharp),
          label: 'Routes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
