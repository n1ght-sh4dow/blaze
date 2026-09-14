import 'package:cloud_firestore/cloud_firestore.dart';

class Territory {
  final String id;
  final GeoPoint location;
  final String name;
  final int level;
  final String ownerId; // Player ID who controls it
  final int goldPerHour;
  final int crystalsPerHour;
  final DateTime lastClaimedAt;
  final int defendingStrength; // Difficulty to capture

  Territory({
    required this.id,
    required this.location,
    required this.name,
    this.level = 1,
    required this.ownerId,
    this.goldPerHour = 10,
    this.crystalsPerHour = 2,
    required this.lastClaimedAt,
    this.defendingStrength = 10,
  });

  factory Territory.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Territory(
      id: doc.id,
      location: data['location'],
      name: data['name'] ?? 'Territory',
      level: data['level'] ?? 1,
      ownerId: data['ownerId'] ?? 'system',
      goldPerHour: data['goldPerHour'] ?? 10,
      crystalsPerHour: data['crystalsPerHour'] ?? 2,
      lastClaimedAt: (data['lastClaimedAt'] as Timestamp).toDate(),
      defendingStrength: data['defendingStrength'] ?? 10,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'location': location,
      'name': name,
      'level': level,
      'ownerId': ownerId,
      'goldPerHour': goldPerHour,
      'crystalsPerHour': crystalsPerHour,
      'lastClaimedAt': Timestamp.fromDate(lastClaimedAt),
      'defendingStrength': defendingStrength,
    };
  }
}
