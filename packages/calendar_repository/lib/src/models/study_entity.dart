import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class StudyEntity extends Equatable {
  const StudyEntity(this.id, this.date);

  final String id;
  final DateTime? date;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'date': date,
      };

  static StudyEntity fromJson(Map<String, dynamic> json) => StudyEntity(
        json['id'] as String,
        json['date'] as DateTime,
      );

  static StudyEntity fromSnapshot(DocumentSnapshot snap) => StudyEntity(
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
