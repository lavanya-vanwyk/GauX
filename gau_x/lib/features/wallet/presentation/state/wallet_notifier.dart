import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../features/booking/presentation/state/booking_notifier.dart';

class WalletNotifier extends ChangeNotifier {
  double _balance = 350.00;
  List<Map<String, dynamic>> _recentTrips = [];
  bool _isLoading = true;

  double get balance => _balance;
  List<Map<String, dynamic>> get recentTrips => _recentTrips;
  bool get isLoading => _isLoading;

  WalletNotifier() {
    _loadWalletData();
  }

  Future<void> _loadWalletData() async {
    final prefs = await SharedPreferences.getInstance();
    
    _balance = prefs.getDouble('wallet_balance') ?? 350.00;
    
    final tripsString = prefs.getString('recent_trips');
    if (tripsString != null) {
      final List<dynamic> decoded = jsonDecode(tripsString);
      _recentTrips = decoded.cast<Map<String, dynamic>>();
    } else {
      _recentTrips = [
        {'route': 'Train: Pretoria -> Sandton', 'cost': -86.00, 'date': 'Today, 08:15'},
        {'route': 'Train: Sandton -> Rosebank', 'cost': -32.00, 'date': 'Yesterday, 17:30'},
      ];
    }
    _isLoading = false;
    notifyListeners();
  }

  // Added for Ticket 5.4 
  bool canAffordRide(double fareAmount) {
    return _balance >= fareAmount;
  }

  // Updated to accept RideType for accurate history logging
  Future<void> processRidePayment(double amount, RideType rideType) async {
    _balance -= amount;
    
    String rideTypeName = rideType == RideType.pool ? 'GauX Pool' : 'GauX Private';
    
    _recentTrips.insert(0, {
      'route': '$rideTypeName: Sandton',
      'cost': -amount,
      'date': 'Just now',
    });
    
    notifyListeners();
    await _saveWalletData();
  }
  Future<void> topUpWallet(double amount, String paymentMethod) async {
    _balance += amount;
    
    _recentTrips.insert(0, {
      'route': 'Top Up: $paymentMethod',
      'cost': amount, // Positive value for top-ups
      'date': 'Just now',
    });
    
    notifyListeners();
    await _saveWalletData();
  }

  Future<void> _saveWalletData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('wallet_balance', _balance);
    await prefs.setString('recent_trips', jsonEncode(_recentTrips));
  }
}