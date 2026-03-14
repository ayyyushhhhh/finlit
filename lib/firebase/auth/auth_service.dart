import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final GoogleSignIn _googleSignIn;

  AuthService() {
    // Initialize GoogleSignIn with web-specific configuration
    if (kIsWeb) {
      _googleSignIn = GoogleSignIn(
        clientId:
            '768641326836-6t608lk9h8kbmp6h5vdon25in65n0obf.apps.googleusercontent.com',
        scopes: ['email', 'profile'],
      );
    } else {
      _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
    }
  }

  User? get currentFirebaseUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign in with Google using Firebase Auth (web-compatible approach).
  /// Returns the [User] on success, null on cancel/failure.
  Future<User?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // For web: Use Firebase Auth's Google provider directly
        // This is more reliable than the deprecated google_sign_in method
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();

        final userCredential = await _auth.signInWithPopup(googleProvider);
        return userCredential.user;
      } else {
        // For mobile: Use traditional google_sign_in approach
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) return null; // user cancelled

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCredential = await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Sign out from both Firebase and Google.
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  /// Delete the current Firebase Auth user and sign out Google.
  Future<void> deleteAccount() async {
    await _auth.currentUser?.delete();
    await _googleSignIn.signOut();
  }
}
