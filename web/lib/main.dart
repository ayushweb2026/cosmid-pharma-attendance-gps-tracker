import 'package:flutter/material.dart';
import 'screens/admin_dashboard.dart';
import 'screens/attendance_reports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const AdminDashboardHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AdminDashboardHome extends StatefulWidget {
  const AdminDashboardHome({Key? key}) : super(key: key);

  @override
  State<AdminDashboardHome> createState() => _AdminDashboardHomeState();
}

class _AdminDashboardHomeState extends State<AdminDashboardHome> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const AdminDashboardScreen(),
    const AttendanceReportsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.location_on),
                selectedIcon: Icon(Icons.location_on),
                label: Text('Live Tracking'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.assessment),
                selectedIcon: Icon(Icons.assessment),
                label: Text('Reports'),
              ),
            ],
          ),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
