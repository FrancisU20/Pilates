import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoutesProvider extends ChangeNotifier {
  bool _isFirstTime = true;

  bool get isFirstTime => _isFirstTime;

  RoutesProvider() {
    _loadFirstTimeStatus();
  }

  Future<void> _loadFirstTimeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isFirstTime = prefs.getBool('isFirstTime') ?? true;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    _isFirstTime = false;
    notifyListeners();
  }
}
