import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stats_repository/stats_repository.dart';

class StatsRepository {
  final instance = FirebaseFirestore.instance;

  Future<PlayerStats> getPlayerStats({
    required String playerId,
  }) async {
    final snap = await instance
        .collection('profiles')
        .doc(playerId)
        .collection('performance')
        .doc('stats')
        .get();
    return PlayerStats.fromEntity(PlayerStatsEntity.fromSnapshot(snap));
  }

  Future<List<PlayerStats>> getPlayerListStats({
    required List<String> playerIds,
  }) async {
    final playersStats = <PlayerStats>[];
    for (var i = 0; i < playerIds.length; i++) {
      final id = playerIds[i];
      playersStats.add(await getPlayerStats(playerId: id));
    }
    return playersStats;
  }

  Future<void> postPlayerStats({
    required PlayerStats stats,
  }) async {
    final doc = instance
        .collection('profiles')
        .doc(stats.playerId)
        .collection('performance')
        .doc('stats');
    await doc.set(stats.toEntity().toDocument());
  }
}
