import 'package:flight_info/screens/FlightScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/HomeScreen.dart';
import '../screens/LoginScreen.dart';
import '../screens/SignupScreen.dart';

import '../data/Flight.dart';

Future<GoRouter> getRouter() async {
  final prefs = await SharedPreferences.getInstance();
  final prefValue = prefs.getBool('is_logged_in');
  return GoRouter(
    initialLocation: (prefValue == null || prefValue == false) ? '/login' : '/home',
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
          path: '/signup',
          builder: (BuildContext context, GoRouterState state) {
            return const SignupScreen();
          }
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
          path: '/flight',
          builder: (BuildContext context, GoRouterState state) {
            return FlightScreen(
                flight: Flight.fromJson(state.extra as Map<String, dynamic>));
          }
      )
    ],
  );
}
