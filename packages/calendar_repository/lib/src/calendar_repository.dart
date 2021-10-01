import 'package:calendar_repository/calendar_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> postMatch({
    required String teamId,
    required Match match,
  }) async {
    final collection = teamsCollection.doc(teamId).collection('matches');
    final doc = collection.doc();
    match = match.copyWith(id: doc.id);
    await doc.set(match.toEntity().toDocument());
  }

  Future<void> postMeeting({
    required String teamId,
    required List<Meeting> meetings,
  }) async {
    final collection = teamsCollection.doc(teamId).collection('meetings');
    for (var meeting in meetings) {
      final doc = collection.doc();
      meeting = meeting.copyWith(id: doc.id);
      await doc.set(meeting.toEntity().toDocument());
    }
  }

  Future<void> postStudy({
    required String teamId,
    required List<Study> studyList,
  }) async {
    final collection = teamsCollection.doc(teamId).collection('study');
    for (var study in studyList) {
      final doc = collection.doc();
      study = study.copyWith(id: doc.id);
      await doc.set(study.toEntity().toDocument());
    }
  }

  Future<void> postTraining({
    required String teamId,
    required List<Training> trainings,
  }) async {
    final collection = teamsCollection.doc(teamId).collection('trainings');
    for (var training in trainings) {
      final doc = collection.doc();
      training = training.copyWith(id: doc.id);
      await doc.set(training.toEntity().toDocument());
    }
  }

  // MATCH
  Future<void> putMatch({
    required String teamId,
    required Match match,
  }) async {
    final collection = teamsCollection.doc(teamId).collection('matches');
    final doc = collection.doc(match.id);
    await doc.set(match.toEntity().toDocument());
  }

  Future<void> postFootballMatchEvents({
    required String teamId,
    required String matchId,
    required FootballMatchEvents events,
  }) async {
    final collection = teamsCollection
        .doc(teamId)
        .collection('matches')
        .doc(matchId)
        .collection('events');
    final braval = collection.doc('braval');
    final rival = collection.doc('rival');
    await braval.set(events.braval.toEntity().toDocument());
    await rival.set(events.rival.toEntity().toDocument());
  }
}
