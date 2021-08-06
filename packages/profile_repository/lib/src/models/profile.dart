import 'package:equatable/equatable.dart';

import 'package:profile_repository/profile_repository.dart';

class Profile extends Equatable {
  const Profile({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.birthday,
    required this.dateCreated,
    required this.currentTeam,
    required this.teamHistory,
    required this.avatarURL,
    required this.achievements,
  });

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

  Profile copyWith({
    String? id,
    String? name,
    String? surname,
    String? email,
    DateTime? birthday,
    DateTime? dateCreated,
    String? currentTeam,
    List<String>? teamHistory,
    String? avatarURL,
    List<String>? achievements,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      dateCreated: dateCreated ?? this.dateCreated,
      currentTeam: currentTeam ?? this.currentTeam,
      teamHistory: teamHistory ?? this.teamHistory,
      avatarURL: avatarURL ?? this.avatarURL,
      achievements: achievements ?? this.achievements,
    );
  }

  static const empty = Profile(
    id: '',
    name: '',
    surname: '',
    email: '',
    birthday: null,
    dateCreated: null,
    currentTeam: '',
    teamHistory: [],
    avatarURL: '',
    achievements: [],
  );

  bool get isEmpty => this == Profile.empty;

  bool get isNotEmpty => this != Profile.empty;

  ProfileEntity toEntity() => ProfileEntity(
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
      );

  static Profile fromEntity(ProfileEntity entity) => Profile(
        id: entity.id,
        name: entity.name,
        surname: entity.surname,
        email: entity.email,
        birthday: entity.birthday,
        dateCreated: entity.dateCreated,
        currentTeam: entity.currentTeam,
        teamHistory: entity.teamHistory,
        avatarURL: entity.avatarURL,
        achievements: entity.achievements,
      );

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
