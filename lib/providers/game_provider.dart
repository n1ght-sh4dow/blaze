import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import '../models/creature.dart';
import '../models/territory.dart';

class GameProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Location _location = Location();

  List<Creature> _playerCreatures = [];
  List<Territory> _nearbyTerritories = [];
  List<Creature> _nearbyCreatures = [];
  bool _isLoading = false;
  LocationData? _currentLocation;

  List<Creature> get playerCreatures => _playerCreatures;
  List<Territory> get nearbyTerritories => _nearbyTerritories;
  List<Creature> get nearbyCreatures => _nearbyCreatures;
  bool get isLoading => _isLoading;
  LocationData? get currentLocation => _currentLocation;

  Future<void> initializeLocation() async {
    try {
      _isLoading = true;
      notifyListeners();

      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) return;
      }

      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) return;
      }

      _currentLocation = await _location.getLocation();
      await loadNearbyContent();

      _location.onLocationChanged.listen((newLocation) {
        _currentLocation = newLocation;
        loadNearbyContent();
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPlayerCreatures(String playerId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final snapshot = await _firestore
          .collection('creatures')
          .where('ownerId', isEqualTo: playerId)
          .get();

      _playerCreatures =
          snapshot.docs.map((doc) => Creature.fromFirestore(doc)).toList();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadNearbyContent() async {
    if (_currentLocation == null) return;

    try {
      // Load nearby territories
      final territoriesSnapshot = await _firestore
          .collection('territories')
          .where('location',
              isLessThan: GeoPoint(
                _currentLocation!.latitude! + 0.05,
                _currentLocation!.longitude! + 0.05,
              ))
          .where('location',
              isGreaterThan: GeoPoint(
                _currentLocation!.latitude! - 0.05,
                _currentLocation!.longitude! - 0.05,
              ))
          .get();

      _nearbyTerritories = territoriesSnapshot.docs
          .map((doc) => Territory.fromFirestore(doc))
          .toList();

      notifyListeners();
    } catch (e) {
      print('Error loading nearby content: $e');
    }
  }

  Future<bool> catchCreature(String creatureId, String playerId) async {
    try {
      await _firestore.collection('creatures').doc(creatureId).update({
        'ownerId': playerId,
        'caughtAt': Timestamp.now(),
      });
      await loadPlayerCreatures(playerId);
      return true;
    } catch (e) {
      print('Error catching creature: $e');
      return false;
    }
  }

  Future<bool> claimTerritory(String territoryId, String playerId) async {
    try {
      await _firestore.collection('territories').doc(territoryId).update({
        'ownerId': playerId,
        'lastClaimedAt': Timestamp.now(),
      });
      await loadNearbyContent();
      return true;
    } catch (e) {
      print('Error claiming territory: $e');
      return false;
    }
  }
}
