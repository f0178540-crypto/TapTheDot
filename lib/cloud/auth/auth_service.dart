import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<User> ensureLoggedIn() async {
    if (_auth.currentUser != null) {
      return _auth.currentUser!;
    }

    try {
      final cred = await _auth.signInAnonymously();
      if (cred.user == null) {
        throw Exception("Anonymous login failed");
      }
      debugPrint("Anonymous login OK: ${cred.user!.uid}");
      return cred.user!;
    } catch (e) {
      debugPrint("Auth error: $e");
      rethrow;
    }
  }
}
