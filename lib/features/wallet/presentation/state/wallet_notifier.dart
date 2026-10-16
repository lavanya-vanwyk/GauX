import 'package:flutter/material.dart';

class WalletNotifier extends ChangeNotifier {
  // Hardcoded initial balance as per AC
  final double _balance = 350.00;
  
  // Mock recent trips data
  final List<Map<String, dynamic>> _recentTrips = [
    {'route': 'Train: Pretoria -> Sandton', 'cost': -86.00, 'date': 'Today, 08:15'},
    {'route': 'Train: Sandton -> Rosebank', 'cost': -32.00, 'date': 'Yesterday, 17:30'},
  ];

  double get balance => _balance;
  List<Map<String, dynamic>> get recentTrips => _recentTrips;
}
