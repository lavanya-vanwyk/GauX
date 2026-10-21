import 'package:flutter/material.dart';

class WalletNotifier extends ChangeNotifier {
  double _balance = 350.00;

  final List<Map<String, dynamic>> _recentTrips = [
    {'route': 'Train: Pretoria -> Sandton', 'cost': -86.00, 'date': 'Today, 08:15'},
    {'route': 'Train: Sandton -> Rosebank', 'cost': -32.00, 'date': 'Yesterday, 17:30'},
  ];

  double get balance => _balance;
  List<Map<String, dynamic>> get recentTrips => _recentTrips;

  void processRidePayment(double amount) {
    _balance -= amount;
    _recentTrips.insert(0, {
      'route': 'Last-Mile Ride: Sandton',
      'cost': -amount,
      'date': 'Just now',
    });
    notifyListeners();
  }
}