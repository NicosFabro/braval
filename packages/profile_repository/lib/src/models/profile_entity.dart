import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  const ProfileEntity(
    this.id,
    this.name,
    this.surname,
    this.email,
    this.birthday,
    this.dateCreated,
    this.currentTeam,
    this.teamHistory,
    this.avatarURL,
    this.achievements,
  );

  final String id;
  final String name;
  final String surname;
  final String email;
  final DateTime? birthday;
  final DateTime? dateCreated;
  final String currentTeam;
  final List<String> teamHistory;
  final String avatarURL;
  final List<String> achievements;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'surname': surname,
        'email': email,
        'birthday': birthday,
        'dateCreated': dateCreated,
        'currentTeam': currentTeam,
        'teamHistory': teamHistory,
        'avatarURL': avatarURL,
        'achievements': achievements,
      };

  static ProfileEntity fromJson(Map<String, dynamic> json) => ProfileEntity(
        json['id'] as String,
        json['name'] as String,
        json['surname'] as String,
        json['email'] as String,
        json['birthday'] as DateTime,
        json['dateCreated'] as DateTime,
        json['currentTeam'] as String,
        json['teamHistory'] as List<String>,
        json['avatarURL'] as String,
        json['achievements'] as List<String>,
      );

  static ProfileEntity fromSnapshot(DocumentSnapshot snap) => ProfileEntity(
        snap.get('id') as String,
        snap.get('name') as String,
        snap.get('surname') as String,
        snap.get('email') as String,
        (snap.get('birthday') as Timestamp).toDate(),
        (snap.get('dateCreated') as Timestamp).toDate(),
        snap.get('currentTeam') as String,
        (snap.get('teamHistory') as List<dynamic>).cast<String>(),
        snap.get('avatarURL') as String,
        (snap.get('achievements') as List<dynamic>).cast<String>(),
      );

  Map<String, dynamic> toDocument() => <String, dynamic>{
        'id': id,
        'name': name,
        'surname': surname,
        'email': email,
        'birthday': birthday ?? DateTime.utc(1970),
        'dateCreated': dateCreated,
        'currentTeam': currentTeam,
        'teamHistory': teamHistory,
        'avatarURL': avatarURL,
        'achievements': achievements,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        surname,
        email,
        birthday,
        dateCreated,
        currentTeam,
        teamHistory,
        avatarURL,
        achievements,
      ];
}
