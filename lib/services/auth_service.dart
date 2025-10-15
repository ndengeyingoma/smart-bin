import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import 'database_service.dart';

class AuthService with ChangeNotifier {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final DatabaseService _db = DatabaseService();
  User? _user;
  bool _isLoading = false;
  StreamSubscription<auth.User?>? _userSubscription;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;
  bool get isAdmin => _user?.role == 'admin';

  AuthService() {
    _userSubscription = _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }

  Future<void> _onAuthStateChanged(auth.User? firebaseUser) async {
    if (firebaseUser == null) {
      _user = null;
    } else {
      final token = await firebaseUser.getIdToken();
      final userFromDb = await _db.getUser(firebaseUser.uid);
      _user = userFromDb != null
          ? User(
              id: userFromDb.id,
              username: userFromDb.username,
              email: userFromDb.email,
              role: userFromDb.role,
              token: token,
            )
          : null;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // Re-throw the exception to be handled by the UI
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
