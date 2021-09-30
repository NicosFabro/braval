import 'package:braval/profile/bloc/profile_bloc.dart';
import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchPlayerChoose extends ModalRoute<String> {
  MatchPlayerChoose({required this.players});

  final List<String> players;

  @override
  Color? get barrierColor => BravalColors.black.withOpacity(0.9);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  bool get opaque => false;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Selecciona el autor', style: BravalTextStyle.headline2),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final list = state.teamPlayersProfiles
                  .where((element) => players.contains(element.id))
                  .toList();

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                ),
                padding: const EdgeInsets.only(top: 16),
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, i) => PlayerAvatar(
                  profile: list[i],
                  onTap: () => Navigator.of(context).pop<String>(list[i].id),
                ),
              );
              // for (int i = 0; i < players.length; i++) Text(players[i]),
            },
          ),
        ],
      ),
    );
  }
}
