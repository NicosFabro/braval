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
    final sport = _getSportName(teamBloc.state.team.sport);
    final category = teamBloc.state.team.category.toLowerCase();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                BravalSpaces.bigSeparator,
                PlayerAvatar(profile: profile, onTap: () {}),
                Text(
                  '${profile.name} ${profile.surname}',
                  style: BravalTextStyle.headline2,
                ),
                BravalSpaces.mediumSeparator,
                PlayerInfoCard(
                  team: '$sport $category',
                  position: 'Portero',
                  schoolYear: '3 ESO',
                  backNumber: '6',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
