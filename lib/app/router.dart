import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/delivery/presentation/proof_of_delivery_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/onboarding/presentation/splash_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/scanner/presentation/qr_scanner_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/shipments/presentation/create_shipment_screen.dart';
import '../features/shipments/presentation/shipment_detail_screen.dart';
import '../features/shipments/presentation/shipment_list_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/shipments',
      builder: (context, state) => const ShipmentListScreen(),
    ),
    GoRoute(
      path: '/shipments/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return ShipmentDetailScreen(shipmentId: id);
      },
    ),
    GoRoute(
      path: '/create-shipment',
      builder: (context, state) => const CreateShipmentScreen(),
    ),
    GoRoute(
      path: '/delivery/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return ProofOfDeliveryScreen(shipmentId: id);
      },
    ),
    GoRoute(
      path: '/scan',
      builder: (context, state) => const QRScannerScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Route not found: ${state.uri}'),
    ),
  ),
);
