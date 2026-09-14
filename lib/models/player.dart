import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String uid;
  final String username;
  final String email;
  final int level;
  final int experience;
  final int gold;
  final int crystals;
  final int energy;
  final int maxEnergy;
  final List<String> creatureIds; // IDs of creatures player owns
  final int killCount;
  final int defenseCount;
  final DateTime createdAt;
  final GeoPoint? lastLocation;

  Player({
    required this.uid,
    required this.username,
    required this.email,
    this.level = 1,
    this.experience = 0,
    this.gold = 500,
    this.crystals = 0,
    this.energy = 100,
    this.maxEnergy = 100,
    this.creatureIds = const [],
    this.killCount = 0,
    this.defenseCount = 0,
    required this.createdAt,
    this.lastLocation,
  });

  factory Player.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Player(
      uid: doc.id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      level: data['level'] ?? 1,
      experience: data['experience'] ?? 0,
      gold: data['gold'] ?? 500,
      crystals: data['crystals'] ?? 0,
      energy: data['energy'] ?? 100,
      maxEnergy: data['maxEnergy'] ?? 100,
      creatureIds: List<String>.from(data['creatureIds'] ?? []),
      killCount: data['killCount'] ?? 0,
      defenseCount: data['defenseCount'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastLocation: data['lastLocation'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'email': email,
      'level': level,
      'experience': experience,
      'gold': gold,
      'crystals': crystals,
      'energy': energy,
      'maxEnergy': maxEnergy,
      'creatureIds': creatureIds,
      'killCount': killCount,
      'defenseCount': defenseCount,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLocation': lastLocation,
    };
  }
}
