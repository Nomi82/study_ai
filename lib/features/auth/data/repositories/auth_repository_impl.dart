import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'repositories.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl(this._auth, this._firestore);

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  @override
  Future<User?> signInAnonymously() async {
    final credential = await _auth.signInAnonymously();
    await _createUserIfNotExists(credential.user);
    return credential.user;
  }

  @override
  Future<User?> signInWithGoogle() async {
    final googleProvider = GoogleAuthProvider();
    final credential = await _auth.signInWithProvider(googleProvider);
    await _createUserIfNotExists(credential.user);
    return credential.user;
  }

  @override
  Future<void> signOut() => _auth.signOut();

  Future<void> _createUserIfNotExists(User? user) async {
    if (user == null) return;

    final doc = _firestore.collection('users').doc(user.uid);
    final snapshot = await doc.get();

    if (!snapshot.exists) {
      await doc.set({
        'email': user.email,
        'isPremium': false,
        'credits': 10,
        'createdAt': FieldValue.serverTimestamp(),
        'provider': user.providerData.first.providerId,
      });
    }
  }
}
