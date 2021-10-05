import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:team_repository/team_repository.dart';

class TeamRepository {
  final teamsCollection = FirebaseFirestore.instance.collection('teams');

  Future<List<Team>> getAllTeams() async {
    final query = await teamsCollection.get();
    return query.docs
        .map((snap) => Team.fromEntity(TeamEntity.fromSnapshot(snap)))
        .toList();
  }

  Future<Team> getTeamById(String teamId) async {
    final teamSnap = await teamsCollection.doc(teamId).get();
    final teamPlayersSnap =
        await teamsCollection.doc(teamId).collection('players').get();
    final teamPlayers = teamPlayersSnap.docs
        .map(
          (snap) => TeamPlayer.fromEntity(TeamPlayerEntity.fromSnapshot(snap)),
        )
        .toList();

    return Team.fromEntity(TeamEntity.fromSnapshot(teamSnap))
        .copyWith(players: teamPlayers);
  }

  Future<Team> getAllTeamsBySport(String sport) async {
    final query = await teamsCollection.where('sport', isEqualTo: sport).get();
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
    final volunteers = teamsCollection.doc(teamId).collection('volunteers');
    final ref = volunteers.doc(volunteerId);
    await ref.set(<String, dynamic>{'role': role, 'id': volunteerId});
  }

  Future<void> updatePlayerListStats(
    String teamId,
    List<TeamPlayer> players,
  ) async {
    final playersCollection = teamsCollection.doc(teamId).collection('players');
    for (final player in players) {
      await playersCollection
          .doc(player.id)
          .set(player.toEntity().toDocument());
    }
  }

  Future<void> updatePlayerStats(
    String teamId,
    TeamPlayer player,
  ) async {
    final playersCollection = teamsCollection.doc(teamId).collection('players');
    await playersCollection.doc(player.id).set(player.toEntity().toDocument());
  }
}
