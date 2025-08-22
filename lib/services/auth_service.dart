import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userEmail;
  String? _userPhone;

  bool get isAuthenticated => _isAuthenticated;
  String? get userEmail => _userEmail;
  String? get userPhone => _userPhone;

  // Simulate email/password login
  Future<bool> loginWithEmail(String email, String password) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Always succeed - it's a dummy page!
    _isAuthenticated = true;
    _userEmail = email;
    _userPhone = null;
    notifyListeners();
    return true;
  }

  // Simulate registration
  Future<bool> registerWithEmail(String email, String password) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Always succeed - it's a dummy page!
    return true;
  }

  // Simulate OTP login
  Future<bool> loginWithOtp(String otp) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Always succeed - it's a dummy page!
    _isAuthenticated = true;
    _userEmail = null;
    _userPhone = '+959123456789'; // Demo phone number
    notifyListeners();
    return true;
  }

  // Logout
  void logout() {
    _isAuthenticated = false;
    _userEmail = null;
    _userPhone = null;
    notifyListeners();
  }

  // Check if user is authenticated
  bool get isLoggedIn => _isAuthenticated;
}
