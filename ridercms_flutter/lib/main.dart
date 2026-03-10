import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/map_screen.dart';
import 'screens/scan_screen.dart';
import 'screens/slot_assigned_screen.dart';
import 'screens/charging_screen.dart';
import 'screens/battery_ready_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/payment_processing_screen.dart';
import 'screens/payment_success_screen.dart';
import 'screens/collect_screen.dart';
import 'screens/session_complete_screen.dart';

void main() {
  runApp(const RidercmsApp());
}

class RidercmsApp extends StatelessWidget {
  const RidercmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ridercms',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/map': (context) => const MapScreen(),
        '/scan': (context) => const ScanScreen(),
        '/slot-assigned': (context) => const SlotAssignedScreen(),
        '/charging': (context) => const ChargingScreen(),
        '/battery-ready': (context) => const BatteryReadyScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/payment-processing': (context) => const PaymentProcessingScreen(),
        '/payment-success': (context) => const PaymentSuccessScreen(),
        '/collect': (context) => const CollectScreen(),
        '/session-complete': (context) => const SessionCompleteScreen(),
      },
    );
  }
}
