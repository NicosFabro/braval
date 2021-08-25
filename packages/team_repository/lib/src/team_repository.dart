import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:team_repository/team_repository.dart';

class TeamRepository {
  final teamsRepository = FirebaseFirestore.instance.collection('teams');

  Future<List<Team>> getAllTeams() async {
    final query = await teamsRepository.get();
    return query.docs
        .map((snap) => Team.fromEntity(TeamEntity.fromSnapshot(snap)))
        .toList();
  }

  Future<Team> getAllTeamsBySport(String sport) async {
    final query = await teamsRepository.where('sport', isEqualTo: sport).get();
    if (query.docs.isEmpty) {
      return Team.empty;
    } else {
      return Team.fromEntity(TeamEntity.fromSnapshot(query.docs.first));
    }
  }

  Future<void> addVolunteer(
    String teamId,
    String volunteerId,
    String role,
  ) async {
    final volunteers = teamsRepository.doc(teamId).collection('volunteers');
    final ref = volunteers.doc(volunteerId);
    await ref.set(<String, dynamic>{'role': role, 'id': volunteerId});
  }
}
