import 'package:cloud_firestore/cloud_firestore.dart';

enum CreatureRarity { common, rare, epic, legendary }

class Creature {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final CreatureRarity rarity;
  final int baseAttack;
  final int baseDefense;
  final int baseHealth;
  final List<String> types; // e.g., ['fire', 'electric']
  final DateTime createdAt;
  final String ownerId; // Player who caught it

  Creature({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rarity,
    required this.baseAttack,
    required this.baseDefense,
    required this.baseHealth,
    required this.types,
    required this.createdAt,
    required this.ownerId,
  });

  factory Creature.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Creature(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      rarity: CreatureRarity.values[
          data['rarity'] ?? CreatureRarity.common.index],
      baseAttack: data['baseAttack'] ?? 10,
      baseDefense: data['baseDefense'] ?? 10,
      baseHealth: data['baseHealth'] ?? 50,
      types: List<String>.from(data['types'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      ownerId: data['ownerId'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'rarity': rarity.index,
      'baseAttack': baseAttack,
      'baseDefense': baseDefense,
      'baseHealth': baseHealth,
      'types': types,
      'createdAt': Timestamp.fromDate(createdAt),
      'ownerId': ownerId,
    };
  }
}
