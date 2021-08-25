import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:calendar_repository/calendar_repository.dart';

class CalendarRepository {
  final teamsCollection = FirebaseFirestore.instance.collection('teams');

  Stream<List<Match>> getAllMatches(String teamId) {
    return teamsCollection.doc(teamId).collection('matches').snapshots().map(
          (snap) => snap.docs
              .map((doc) => Match.fromEntity(MatchEntity.fromSnapshot(doc)))
              .toList(),
        );
  }

  Stream<List<Meeting>> getAllMeetings(String teamId) {
    return teamsCollection.doc(teamId).collection('meetings').snapshots().map(
          (snap) => snap.docs
              .map((doc) => Meeting.fromEntity(MeetingEntity.fromSnapshot(doc)))
              .toList(),
        );
  }

  Stream<List<Study>> getAllStudy(String teamId) {
    return teamsCollection.doc(teamId).collection('study').snapshots().map(
          (snap) => snap.docs
              .map((doc) => Study.fromEntity(StudyEntity.fromSnapshot(doc)))
              .toList(),
        );
  }

  Stream<List<Training>> getAllTrainings(String teamId) {
    return teamsCollection.doc(teamId).collection('trainings').snapshots().map(
          (snap) => snap.docs
              .map(
                (doc) => Training.fromEntity(TrainingEntity.fromSnapshot(doc)),
              )
              .toList(),
        );
  }

  // Future<List<Study>> getAllStudy(String teamId) async {
  //   final team = teamsCollection.doc(teamId);
  //   final study = await team.collection('study').get();
  //   return study.docs
  //       .map((snap) => Study.fromEntity(StudyEntity.fromSnapshot(snap)))
  //       .toList();
  // }

  // Future<List<Training>> getAllTrainings(String teamId) async {
  //   final team = teamsCollection.doc(teamId);
  //   final trainings = await team.collection('trainings').get();
  //   return trainings.docs
  //       .map((snap) => Training.fromEntity(TrainingEntity.fromSnapshot(snap)))
  //       .toList();
  // }
}
