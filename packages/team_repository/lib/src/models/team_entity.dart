import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TeamEntity extends Equatable {
  const TeamEntity(
    this.id,
    this.sport,
    this.category,
    this.year,
  );

  final String id;
  final String sport;
  final String category;
  final String year;

  Map<String, String> toJson() => {
        'id': id,
        'sport': sport,
        'category': category,
        'year': year,
      };

  static TeamEntity fromJson(Map<String, dynamic> json) => TeamEntity(
        json['id'] as String,
        json['sport'] as String,
        json['category'] as String,
        json['year'] as String,
      );

  static TeamEntity fromSnapshot(DocumentSnapshot snap) => TeamEntity(
        snap.get('id') as String,
        snap.get('sport') as String,
        snap.get('category') as String,
        snap.get('year') as String,
      );

  Map<String, String> toDocument() => {
        'id': id,
        'sport': sport,
        'category': category,
        'year': year,
      };

  @override
  List<Object?> get props => [id, sport, category, year];
}
