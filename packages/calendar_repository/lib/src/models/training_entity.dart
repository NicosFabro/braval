import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TrainingEntity extends Equatable {
  const TrainingEntity(this.id, this.date);

  final String id;
  final DateTime? date;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'date': date,
      };

  static TrainingEntity fromJson(Map<String, dynamic> json) => TrainingEntity(
        json['id'] as String,
        json['date'] as DateTime,
      );

  static TrainingEntity fromSnapshot(DocumentSnapshot snap) => TrainingEntity(
        snap.get('id') as String,
        snap.get('date') as DateTime,
      );

  Map<String, dynamic> toDocument() => <String, dynamic>{
        'id': id,
        'date': date,
      };

  @override
  List<Object?> get props => [id, date];
}
