import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MeetingEntity extends Equatable {
  const MeetingEntity(this.id, this.date);

  final String id;
  final DateTime? date;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'date': date,
      };

  static MeetingEntity fromJson(Map<String, dynamic> json) => MeetingEntity(
        json['id'] as String,
        json['date'] as DateTime,
      );

  static MeetingEntity fromSnapshot(DocumentSnapshot snap) => MeetingEntity(
        snap.get('id') as String,
        (snap.get('date') as Timestamp).toDate(),
      );

  Map<String, dynamic> toDocument() => <String, dynamic>{
        'id': id,
        'date': date,
      };

  @override
  List<Object?> get props => [id, date];
}
