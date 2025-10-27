import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoggedIn = false;
  SharedPreferences? _prefs;
  String? _userEmail;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;

  /// ✅ Initialize SharedPreferences before use
  Future<void> loadUser() async {
    _prefs = await SharedPreferences.getInstance();
    _userEmail = _prefs?.getString('userEmail');
    _isLoggedIn = _userEmail != null;
    notifyListeners();
  }

  /// ✅ Login simulation (replace with real backend/Firebase if needed)
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Make sure SharedPreferences is ready
      if (_prefs == null) {
        await loadUser();
      }

      // Simulated authentication delay
      await Future.delayed(const Duration(seconds: 2));

      // Simple validation simulation
      if (email.isEmpty || password.isEmpty) {
        throw Exception("Please enter email and password");
      }

      // Save the user email locally
      await _prefs?.setString('userEmail', email);

      _userEmail = email;
      _isLoggedIn = true;
    } catch (e) {
      debugPrint("Login failed: $e");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// ✅ Logout function
  Future<void> logout() async {
    if (_prefs == null) {
      await loadUser();
    }

    await _prefs?.remove('userEmail');
    _userEmail = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
