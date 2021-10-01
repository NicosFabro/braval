// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_repository/profile_repository.dart';

void main() {
  group('User', () {
    const id = 'mock-id';
    const name = 'mock-name';
    const surname = 'mock-surname';
    const email = 'mock-email';
    final birthday = DateTime(2021);
    final dateCreated = DateTime(2021);
    const currentTeam = 'mock-currentTeam';
    const teamHistory = ['mock-teamHistory'];
    const avatarURL = 'mock-avatarURL';
    const achievements = ['mock-achievements'];

    test('uses value equality', () {
      expect(
        Profile(
          id: id,
          name: name,
          surname: surname,
          email: email,
          birthday: birthday,
          dateCreated: dateCreated,
          currentTeam: currentTeam,
          teamHistory: teamHistory,
          avatarURL: avatarURL,
          achievements: achievements,
        ),
        Profile(
          id: id,
          name: name,
          surname: surname,
          email: email,
          birthday: birthday,
          dateCreated: dateCreated,
          currentTeam: currentTeam,
          teamHistory: teamHistory,
          avatarURL: avatarURL,
          achievements: achievements,
        ),
      );
    });

    test('isEmpty returns true for empty profile', () {
      expect(Profile.empty.isEmpty, isTrue);
    });

    test('isEmpty returns false for non-empty profile', () {
      final profile = Profile(
        id: id,
        name: name,
        surname: surname,
        email: email,
        birthday: birthday,
        dateCreated: dateCreated,
        currentTeam: currentTeam,
        teamHistory: teamHistory,
        avatarURL: avatarURL,
        achievements: achievements,
      );
      expect(profile.isEmpty, isFalse);
    });

    test('isNotEmpty returns false for empty profile', () {
      expect(Profile.empty.isNotEmpty, isFalse);
    });

    test('isNotEmpty returns true for non-empty profile', () {
      final profile = Profile(
        id: id,
        name: name,
        surname: surname,
        email: email,
        birthday: birthday,
        dateCreated: dateCreated,
        currentTeam: currentTeam,
        teamHistory: teamHistory,
        avatarURL: avatarURL,
        achievements: achievements,
      );
      expect(profile.isNotEmpty, isTrue);
    });
  });
}
