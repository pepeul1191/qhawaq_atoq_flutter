import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/constants.dart';
import 'home_controller.dart';
import '../trip/trip_page.dart';
import '../trip_summary/trip_summary_page.dart';
import '../about/about_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController control = Get.put(HomeController());

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    TripSummaryPage(),
    TripPage(),
    AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Text('Template Page'),
    );
  }

  Widget _navigationBottom() {
    return BottomNavigationBar(
      backgroundColor: appColor4,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list_outlined),
          label: 'Historial',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.track_changes),
          label: 'Nuevo Vuelo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Acerca de',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: appColor1,
      onTap: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Qhawaq Atoq',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: appColor1,
          actions: [
            // Agregar un menú desplegable al AppBar
          ]),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _navigationBottom(),
    );
  }
}
