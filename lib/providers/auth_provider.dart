import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/player.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  Player? _player;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  Player? get player => _player;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _firebaseAuth.authStateChanges().listen((user) {
      _user = user;
      if (user != null) {
        _loadPlayerData(user.uid);
      } else {
        _player = null;
      }
      notifyListeners();
    });
  }

  Future<bool> signUp(String email, String password, String username) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final player = Player(
        uid: userCredential.user!.uid,
        username: username,
        email: email,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('players')
          .doc(userCredential.user!.uid)
          .set(player.toFirestore());

      _player = player;
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _player = null;
    notifyListeners();
  }

  Future<void> _loadPlayerData(String uid) async {
    try {
      final doc = await _firestore.collection('players').doc(uid).get();
      if (doc.exists) {
        _player = Player.fromFirestore(doc);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading player data: $e');
    }
  }
}
