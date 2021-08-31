import 'package:braval/profile/bloc/profile_bloc.dart';
import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:braval/team/team.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({Key? key}) : super(key: key);

  String _getSportName(String sport) {
    return sport == 'football' ? 'Fútbol' : 'Basket';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: BlocBuilder<TeamBloc, TeamState>(
          builder: (context, state) {
            final sport = _getSportName(state.team.sport);
            final category = state.team.category.toLowerCase();
            return Text('$sport $category');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add, color: BravalColors.black),
      ),
      body: const TeamView(),
    );
  }
}

class TeamView extends StatelessWidget {
  const TeamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeamBloc, TeamState>(
      listener: (context, tState) {
        if (tState.status == TeamStatus.success) {
          final idList = tState.team.players!.map((e) => e.id).toList();
          context
              .read<ProfileBloc>()
              .add(TeamPlayersProfilesFetchRequested(idList));
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, pState) {
          if (pState.teamPlayersProfiles.isEmpty) {
            return const Text('No tienes jugadores');
          }
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: kBottomNavigationBarHeight,
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                ),
                padding: const EdgeInsets.only(top: 16),
                shrinkWrap: true,
                itemCount: pState.teamPlayersProfiles.length,
                itemBuilder: (context, i) => PlayerAvatar(
                  profile: pState.teamPlayersProfiles[i],
                  onTap: () {},
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
