import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TeamPlayerEntity extends Equatable {
  const TeamPlayerEntity(this.id, this.position);

  final String id;
  final String position;

  Map<String, String> toJson() => {'id': id, 'position': position};

  static TeamPlayerEntity fromJson(Map<String, dynamic> json) =>
      TeamPlayerEntity(
        json['id'] as String,
        json['position'] as String,
      );

  static TeamPlayerEntity fromSnapshot(DocumentSnapshot snap) {
    return TeamPlayerEntity(
      snap.get('id') as String,
      snap.get('position') as String,
    );
  }

  Map<String, String> toDocument() => {'id': id, 'position': position};

  @override
  List<Object?> get props => [id, position];
}
