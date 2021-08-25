import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MatchEntity extends Equatable {
  const MatchEntity(
    this.id,
    this.date,
    this.rival,
    this.address,
    this.isLocal,
    this.lineup,
  );

  final String id;
  final DateTime? date;
  final String rival;
  final String address;
  final bool isLocal;
  final List<String> lineup;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'date': date,
        'rival': rival,
        'address': address,
        'isLocal': isLocal,
        'lineup': lineup,
      };

  static MatchEntity fromJson(Map<String, dynamic> json) => MatchEntity(
        json['id'] as String,
        json['date'] as DateTime,
        json['rival'] as String,
        json['address'] as String,
        json['isLocal'] as bool,
        json['lineup'] as List<String>,
      );

  static MatchEntity fromSnapshot(DocumentSnapshot snap) => MatchEntity(
        snap.get('id') as String,
        (snap.get('date') as Timestamp).toDate(),
        snap.get('rival') as String,
        snap.get('address') as String,
        snap.get('isLocal') as bool,
        (snap.get('lineup') as List<dynamic>).cast<String>(),
      );

  Map<String, dynamic> toDocument() => <String, dynamic>{
        'id': id,
        'date': date,
        'rival': rival,
        'address': address,
        'isLocal': isLocal,
        'lineup': lineup,
      };

  @override
  List<Object?> get props => [
        id,
        date,
        rival,
        address,
        isLocal,
        lineup,
      ];
}
