import 'package:braval/stats/stats.dart';
import 'package:braval/team/team.dart';
import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart';

class PlayerProfilePage extends StatelessWidget {
  const PlayerProfilePage({Key? key, required this.profile}) : super(key: key);

  final Profile profile;

  static Route<PlayerProfilePage> route(Profile profile) =>
      MaterialPageRoute<PlayerProfilePage>(
        builder: (context) => PlayerProfilePage(profile: profile),
      );

  String _getSportName(String sport) {
    return sport == 'football' ? 'Fútbol' : 'Basket';
  }

  @override
  Widget build(BuildContext context) {
    final teamBloc = context.read<TeamBloc>();
    final player = teamBloc.state.team.players!.firstWhere(
      (element) => element.id == profile.id,
    );
    final sport = _getSportName(teamBloc.state.team.sport);
    final category = teamBloc.state.team.category.toLowerCase();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 38),
              child: Column(
                children: [
                  PlayerAvatar(profile: profile, onTap: () {}),
                  Text(
                    '${profile.name} ${profile.surname}',
                    style: BravalTextStyle.headline2,
                  ),
                  BravalSpaces.mediumSeparator,
                  PlayerInfoCard(
                    team: '$sport $category',
                    position: player.position.capitalize(),
                    schoolYear: player.schoolYear,
                    backNumber: '${player.backNumber}',
                  ),
                  BravalSpaces.mediumSeparator,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PlayerStatsButton(
                        type: StatsType.study,
                        score: player.evaluationStudy,
                        onTap: () {
                          // Navigator.of(context).push(
                          //   PlayerFootballStats.route(player),
                          // );
                        },
                      ),
                      PlayerStatsButton(
                        type: StatsType.football,
                        score: player.evaluationMatch,
                        onTap: () {
                          Navigator.of(context).push(
                            PlayerFootballStats.route(player),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
